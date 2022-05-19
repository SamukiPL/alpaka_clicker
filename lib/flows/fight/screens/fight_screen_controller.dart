import 'package:alpaka_clicker/flows/fight/domain/fight_repository.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'fight_screen_controller.g.dart';

@injectable
class FightScreenController = _FightScreenControllerBase with _$FightScreenController;

abstract class _FightScreenControllerBase with Store {
  final FightRepository _repository;

  _FightScreenControllerBase(this._repository) {
    listen();
    test();
  }

  @observable
  List<LogModel> logs = List.empty();

  @observable
  HealthModel playerHealth = HealthModel(0, "0:00");

  @observable
  HealthModel enemyHealth = HealthModel(0, "0:00");

  Future<void> listen() async {
    _repository.observeFight().listen((event) {
      logs = event.logs.toList();
      playerHealth = event.playerHealth;
      enemyHealth = event.enemyHealth;
    });
  }

  Future<void> test() async {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      await _repository.makeTurn();
      return true;
    });
  }
}
