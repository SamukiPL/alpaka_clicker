import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:injectable/injectable.dart';

@injectable
class EnemyPersonaltyLevelProbabilityCalculator {
  Probability<int> calculatePersonaltyLevel(int levelSum) {
    return Probability(
      3,
      {
        1: (levelSum * 0.3).round(),
        2: (levelSum * 0.4).round(),
        3: (levelSum * 0.5).round(),
      },
    );
  }
}
