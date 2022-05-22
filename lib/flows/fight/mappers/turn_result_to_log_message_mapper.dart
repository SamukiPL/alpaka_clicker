import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/fight/data/turn_result.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class TurnResultToLogMessageMapper {
  LogModel call(TurnResult turnResult) => LogModel(text: generateLogTest(turnResult), logPerson: turnResult.type);

  String generateLogTest(TurnResult turnResult) {
    if (turnResult.playerHealth.healthPercentage <= 0 || turnResult.enemyHealth.healthPercentage <= 0) {
      return "${turnResult.attackerName} pokonał ${turnResult.defenderName} w walce!";
    }

    final attackerTag = attackAttributeString(turnResult.attackAttribute);
    final defenderTag = defendAttributeString(turnResult.defendAttribute);
    return "${turnResult.attackerName} używa $attackerTag. ${turnResult.defenderName} broni się $defenderTag i otrzymuje ${turnResult.damageDealt} obrażeń";
  }

  //TODO localize and make flavorable
  String attackAttributeString(AttributeTag attribute) {
    switch (attribute) {
      case AttributeTag.rock:
        return "siły";
      case AttributeTag.paper:
        return "charyzmy";
      case AttributeTag.scissors:
        return "zręczności";
      case AttributeTag.knowledge:
        return "wiedzy";
    }
  }

  String defendAttributeString(AttributeTag attribute) {
    switch (attribute) {
      case AttributeTag.rock:
        return "siłą";
      case AttributeTag.paper:
        return "charyzmą";
      case AttributeTag.scissors:
        return "zręcznością";
      case AttributeTag.knowledge:
        return "wiedzą";
    }
  }
}
