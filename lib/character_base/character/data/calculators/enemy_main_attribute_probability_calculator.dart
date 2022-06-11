import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:injectable/injectable.dart';

@injectable
class EnemyMainAttributeProbabilityCalculator {
  Probability<AttributeTag> calculateMainAttribute() {
    const rockProb = 30;
    const paperProb = 30 + rockProb;
    const scissorsProb = 30 + paperProb;
    const knowledgeProb = 10 + scissorsProb;

    final attributesProbabilities = {
      rockProb : AttributeTag.rock,
      paperProb : AttributeTag.paper,
      scissorsProb : AttributeTag.scissors,
      knowledgeProb : AttributeTag.knowledge
    };

    return Probability(knowledgeProb, attributesProbabilities);
  }
}
