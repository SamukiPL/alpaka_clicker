//TODO modification for flavor needed
import 'dart:math';

import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class HealthCalculator {
  HealthModel calculateHealth({required int damageTaken, required int fullHealth}) {
    final healthPercentage = (fullHealth - damageTaken) / fullHealth;
    return HealthModel(healthPercentage, _getDisplayableHealth(min(damageTaken, fullHealth)));
  }

  String _getDisplayableHealth(int damageTaken) {
    final displayableHours = (damageTaken / 60).floor();
    final currentMinutes = damageTaken % 60;
    final displayableMinutes = currentMinutes.toString().padLeft(2, "0");
    return "$displayableHours:$displayableMinutes";
  }
}
