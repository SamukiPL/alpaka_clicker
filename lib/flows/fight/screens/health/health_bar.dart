import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/screens/health/health_widget.dart';
import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  final HealthModel playerHealth;
  final HealthModel enemyHealth;

  const HealthBar({Key? key, required this.playerHealth, required this.enemyHealth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: HealthWidget(playerHealth)),
          Expanded(child: HealthWidget(enemyHealth)),
        ],
      ),
    );
  }
}
