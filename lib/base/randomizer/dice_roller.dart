import 'dart:math';

import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:injectable/injectable.dart';

@injectable
class DiceRoller {
  final Random _random;

  DiceRoller(this._random);

  T roll<T>(Probability<T> probability) {
    final randomized = _random.nextInt(probability.probSum);
    T rolledTag = probability.attributesProp.entries.firstWhere((element) => element.key > randomized).value;
    return rolledTag;
  }
}
