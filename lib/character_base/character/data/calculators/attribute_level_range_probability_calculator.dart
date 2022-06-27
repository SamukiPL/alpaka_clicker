import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';

@injectable
class AttributeLevelRangeProbabilityCalculator {
  final Range startingRange;

  AttributeLevelRangeProbabilityCalculator(@Named("levelRange") this.startingRange);

  Probability<int> calculateRange(int level) {
    final rangeProbability = <int, int>{};
    for (int i = startingRange.first; i <= startingRange.last; i ++) {
      rangeProbability[i] = i + level;
    }
    return Probability(rangeProbability.length, rangeProbability);
  }
}
