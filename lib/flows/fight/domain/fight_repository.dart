import 'package:alpaka_clicker/flows/fight/domain/models/fight_details_model.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';

abstract class FightRepository {
  Stream<FightDetailsModel> startAndObserveFight(DifficultyModel model);
  Future<void> makeTurn();
}
