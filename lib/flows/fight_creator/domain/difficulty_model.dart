import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';
import 'package:alpaka_clicker/util/pair.dart';

class DifficultyModel {
  final DifficultyType type;
  final Range levelRange;
  final int fightsCount;
  final double minHealth;
  final double deathChanges;

  DifficultyModel(this.type, this.levelRange, this.fightsCount, this.minHealth, this.deathChanges);
}
