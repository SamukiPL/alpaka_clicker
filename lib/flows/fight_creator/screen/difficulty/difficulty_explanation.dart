import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:flutter/material.dart';

class DifficultyExplanation extends StatelessWidget {
  final DifficultyModel model;

  const DifficultyExplanation({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.1,
          child: Image.asset(
            "assets/images/enemy_portrait.png",
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            const Text(
              "Możliwe poziomy:",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.levelRange.first.toString()),
                      Text(model.levelRange.last.toString()),
                    ],
                  ),
                  const Divider(
                    color: BaseColors.primary,
                    thickness: 2,
                  ),
                ],
              ),
            ),
            const Text(
              "Ilość walk:",
              textAlign: TextAlign.center,
            ),
            Text(
              model.fightsCount.toString(),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Minimalny poziom życia do ucieczki",
                          textAlign: TextAlign.center,
                        ),
                        CircularProgressIndicator(
                          value: model.minHealth,
                          color: BaseColors.primary,
                          backgroundColor: BaseColors.primary.withOpacity(0.4),
                        ),
                        Text(
                          "${model.minHealth * 100}%",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Szansa na śmierć:",
                          textAlign: TextAlign.center,
                        ),
                        CircularProgressIndicator(
                          value: model.deathChanges,
                          color: BaseColors.primary,
                          backgroundColor: BaseColors.primary.withOpacity(0.4),
                        ),
                        Text(
                          "${model.deathChanges * 100}%",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
