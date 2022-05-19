import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:alpaka_clicker/character_base/character.dart';
import 'package:alpaka_clicker/character_base/character_level.dart';
import 'package:alpaka_clicker/flows/fight/data/fight_director.dart';
import 'package:alpaka_clicker/flows/fight/domain/fight_repository.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/fight_details_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/mappers/turn_result_to_log_message_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: FightRepository)
class FightRepositoryImpl implements FightRepository {
  final FightDirector fightDirector;
  final TurnResultToLogMessageMapper logMessageMapper;

  FightRepositoryImpl(this.fightDirector, this.logMessageMapper) {
    fightDirector.startWithNewEnemy(Character(
        "Papajak",
        CharacterLevel(level: 16, experience: 1, experienceStrategy: 1252),
        Rock(5, Grade.a),
        Paper(2, Grade.b),
        Scissors(4, Grade.s),
        Knowledge(1, Grade.f)));
  }

  final PublishSubject<FightDetailsModel> _detailsSubject = PublishSubject();
  final List<LogModel> logs = List.empty(growable: true);

  @override
  Stream<FightDetailsModel> observeFight() => _detailsSubject.stream;

  @override
  Future<void> makeTurn() async {
    final result = fightDirector.makeTurn();
    logs.insert(0, LogModel(text: "${result.type} give ${result.damageDealt}", logPerson: result.type));
    final details = FightDetailsModel(result.playerHealth, result.enemyHealth, logs);
    _detailsSubject.add(details);
  }

}
