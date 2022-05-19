import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:alpaka_clicker/character_base/character.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProbabilityCalculator {
  final int baseProbability = 25;

  Probability calculateProbability(Character character) {
    final rockProb = baseProbability + getGradeFactor(character.rockGrade);
    final paperProb = baseProbability + getGradeFactor(character.paperGrade) + rockProb;
    final scissorsProb = baseProbability + getGradeFactor(character.scissorsGrade) + paperProb;
    final knowledgeProb = baseProbability + getGradeFactor(character.knowledgeGrade) + scissorsProb;

    final attributesProb = {
      rockProb: AttributeTag.rock,
      paperProb: AttributeTag.paper,
      scissorsProb: AttributeTag.scissors,
      knowledgeProb: AttributeTag.knowledge,
    };

    final probSum = knowledgeProb;
    return Probability(probSum, attributesProb);
  }

  int getGradeFactor(Grade grade) {
    switch (grade) {
      case Grade.s:
        return 30;
      case Grade.a:
        return 20;
      case Grade.b:
        return 15;
      case Grade.c:
        return 5;
      case Grade.d:
        return -5;
      case Grade.e:
        return -15;
      case Grade.f:
        return -24;
    }
  }
}
