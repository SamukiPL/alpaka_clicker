import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/base/randomizer/probability.dart';

class MockDiceRoller implements DiceRoller {
  final T Function<T>(Probability<T>) dummyReturn;

  MockDiceRoller({required this.dummyReturn});

  @override
  T roll<T>(Probability<T> probability) => dummyReturn(probability);
}
