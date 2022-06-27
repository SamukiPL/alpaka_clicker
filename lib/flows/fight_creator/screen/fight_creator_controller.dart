import 'dart:async';

import 'package:alpaka_clicker/flows/fight_creator/domain/change_difficulty_use_case.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/observe_difficulty_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'fight_creator_controller.g.dart';

@injectable
class FightCreatorController = _FightCreatorController with _$FightCreatorController;

abstract class _FightCreatorController with Store {
  final ObserveDifficultyUseCase _observeDifficultyUseCase;
  final ChangeDifficultyUseCase _changeDifficultyUseCase;

  _FightCreatorController(this._observeDifficultyUseCase, this._changeDifficultyUseCase);

  late final StreamSubscription _streamSubscription;

  @observable
  bool isLoading = true;

  @observable
  DifficultyModel? difficultyModel;

  @action
  Future<void> initializeController() async {
    _streamSubscription = _observeDifficultyUseCase().listen((event) {
      difficultyModel = event;
      isLoading = false;
    });
  }

  @action
  Future<void> changeDifficulty(DifficultyType type) async {
    _changeDifficultyUseCase(type);
  }

  Future<void> dispose() async {
    _streamSubscription.cancel();
  }
}
