import 'dart:math';

import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:injectable/injectable.dart';

@injectable
class GradeProbabilityCalculator {
  Probability<Grade> calculateGrades(int level) {
    final fGrade = gradeFCalc(level);
    final eGrade = gradeECalc(level) + fGrade;
    final dGrade = gradeDCalc(level) + eGrade;
    final cGrade = gradeCCalc(level) + dGrade;
    final bGrade = gradeBCalc(level) + cGrade;
    final aGrade = gradeACalc(level) + bGrade;
    final sGrade = gradeSCalc(level) + aGrade;

    final gradesProbability = {
      fGrade: Grade.f,
      eGrade: Grade.e,
      dGrade: Grade.d,
      cGrade: Grade.c,
      bGrade: Grade.b,
      aGrade: Grade.a,
      sGrade: Grade.s,
    }..removeWhere((key, value) => key == 0);
    return Probability(sGrade, gradesProbability);
  }

  int gradeSCalc(int x) => max((-0.0011 * pow(x - 150, 2) + 25).ceil(), 1);

  int gradeACalc(int x) => max((-0.0014 * pow(x - 125, 2) + 25).ceil(), 0);

  int gradeBCalc(int x) => max((-0.002 * pow(x - 100, 2) + 25).ceil(), 0);

  int gradeCCalc(int x) => max((-0.003 * pow(x - 75, 2) + 25).ceil(), 0);

  int gradeDCalc(int x) => max((-0.004 * pow(x - 50, 2) + 25).ceil(), 0);

  int gradeECalc(int x) => max((-0.005 * pow(x - 25, 2) + 25).ceil(), 0);

  int gradeFCalc(int x) => max((-0.02 * pow(x - 1, 2) + 25).ceil(), 0);
}
