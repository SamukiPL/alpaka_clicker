import 'dart:math';

import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability.dart';
import 'package:injectable/injectable.dart';

@injectable
class DiceRoller {
  final Random _random;

  DiceRoller(this._random);

  AttributeTag rollForAttribute(Probability probability) {
    final randomized = _random.nextInt(probability.probSum);
    AttributeTag rolledTag = probability.attributesProp.entries.firstWhere((element) => element.key > randomized).value;
    return rolledTag;
  }
}
