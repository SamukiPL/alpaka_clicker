import 'dart:math';

import 'package:alpaka_clicker/character_base/character/character.dart';

class FightExperienceCalculator {
  int calculateExperience(Character player, Character enemy) {
    final minimalLevel = player.level - 5;
    final diffLevel = enemy.level - minimalLevel;
    return max(diffLevel * 10, 1);
  }
}
