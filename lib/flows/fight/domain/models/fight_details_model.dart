import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';

class FightDetailsModel {
  final HealthModel playerHealth;
  final HealthModel enemyHealth;
  final List<LogModel> logs;

  FightDetailsModel(this.playerHealth, this.enemyHealth, this.logs);
}
