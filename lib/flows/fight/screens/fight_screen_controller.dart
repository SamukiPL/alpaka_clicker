import 'dart:async';

import 'package:alpaka_clicker/flows/fight/domain/fight_repository.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/observe_fight_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'fight_screen_controller.g.dart';

@injectable
class FightScreenController = _FightScreenControllerBase with _$FightScreenController;

abstract class _FightScreenControllerBase with Store {
  final FightRepository _repository;
  final ObserveFightUseCase _observeFightUseCase;

  _FightScreenControllerBase(this._repository, this._observeFightUseCase) {
    listen();
    test();
  }

  late StreamSubscription fightSubscription;

  @observable
  List<LogModel> logs = List.empty();

  @observable
  HealthModel playerHealth = HealthModel(1, "0:00");

  @observable
  HealthModel enemyHealth = HealthModel(1, "0:00");

  Future<void> listen() async {
    fightSubscription = _observeFightUseCase().listen((event) {
      logs = event.logs.toList();
      playerHealth = event.playerHealth;
      enemyHealth = event.enemyHealth;

      if (event.playerHealth.healthPercentage <= 0 || event.enemyHealth.healthPercentage <= 0) {
        testing = false;
      }
    });
  }

  bool testing = true;

  Future<void> test() async {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      await _repository.makeTurn();
      return testing;
    });
  }

  void dispose() {
    fightSubscription.cancel();
  }
}
