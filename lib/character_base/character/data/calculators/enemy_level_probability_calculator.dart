import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';

@injectable
class EnemyLevelProbabilityCalculator {
  Probability<int> calculateRange(Range range) {
    final rangeProbability = <int, int>{};
    for (int i = 0; i <= range.last - range.first; i ++) {
      final key = i + 1;
      rangeProbability[key] = range.first + i;
    }
    return Probability(rangeProbability.length, rangeProbability);
  }
}
