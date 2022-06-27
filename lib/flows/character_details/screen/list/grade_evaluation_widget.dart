
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/util/ext/attribute_ext.dart';
import 'package:flutter/material.dart';

class GradeEvaluationWidget extends StatelessWidget {
  final Grade grade;

  const GradeEvaluationWidget({Key? key, required this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Grade.values.reversed.map((currentGrade) => buildGrade(currentGrade)).toList(),
    );
  }

  Widget buildGrade(Grade currentGrade) {
    final double opacity = (grade == currentGrade) ? 1 : 0.1;
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: defaultRadius(),
        color: currentGrade.gradeColor().withOpacity(opacity),
      ),
    );
  }

}
