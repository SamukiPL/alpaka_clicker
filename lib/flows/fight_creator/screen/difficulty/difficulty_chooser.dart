import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:flutter/material.dart';

class DifficultyChooser extends StatelessWidget {
  final DifficultyType currentChosen;
  final Function(DifficultyType) onChosen;

  const DifficultyChooser({Key? key, required this.currentChosen, required this.onChosen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultDecoration(),
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _difficultyItem("Bądźmy łagodni", currentChosen == DifficultyType.easy, DifficultyType.easy)),
            const SizedBox(
              height: double.infinity,
              child: VerticalDivider(thickness: 1, width: 1, color: BaseColors.primary),
            ),
            Expanded(child: _difficultyItem("Jak mi dadzą to jem", currentChosen == DifficultyType.normal, DifficultyType.normal)),
            const SizedBox(
              height: double.infinity,
              child: VerticalDivider(thickness: 1, width: 1, color: BaseColors.primary),
            ),
            Expanded(child: _difficultyItem("Okrutnik", currentChosen == DifficultyType.hard, DifficultyType.hard)),
          ],
        ),
      ),
    );
  }

  Widget _difficultyItem(String text, bool chosen, DifficultyType type) {
    return Material(
      color: (chosen) ? BaseColors.primary : null,
      child: InkWell(
        onTap: (!chosen) ? () => onChosen(type) : null,
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: (chosen) ? Colors.white : Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }
}
