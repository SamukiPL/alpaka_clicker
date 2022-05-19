import 'package:alpaka_clicker/flows/fight/domain/models/fight_details_model.dart';

abstract class FightRepository {
  Stream<FightDetailsModel> observeFight();
  Future<void> makeTurn();
}
