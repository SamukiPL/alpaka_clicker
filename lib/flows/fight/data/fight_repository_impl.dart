import 'package:alpaka_clicker/character_base/character/data/enemy_generator.dart';
import 'package:alpaka_clicker/character_base/character/models/difficulty_settings.dart';
import 'package:alpaka_clicker/flows/fight/data/fight_director.dart';
import 'package:alpaka_clicker/flows/fight/domain/fight_repository.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/fight_details_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/mappers/turn_result_to_log_message_mapper.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: FightRepository)
class FightRepositoryImpl implements FightRepository {
  final FightDirector fightDirector;
  final TurnResultToLogMessageMapper logMessageMapper;
  final EnemyGenerator enemyGenerator;

  FightRepositoryImpl(this.fightDirector, this.logMessageMapper, this.enemyGenerator);

  final PublishSubject<FightDetailsModel> _detailsSubject = PublishSubject();
  final List<LogModel> logs = List.empty(growable: true);

  @override
  Stream<FightDetailsModel> startAndObserveFight(DifficultyModel model) {
    final newEnemy = enemyGenerator.generateEnemy(DifficultySettings(model.levelRange, model.fightsCount));
    fightDirector.startWithNewEnemy(newEnemy);
    return _detailsSubject.stream;
  }

  @override
  Future<void> makeTurn() async {
    final result = fightDirector.makeTurn();
    logs.insert(0, logMessageMapper.call(result));
    final details = FightDetailsModel(result.playerHealth, result.enemyHealth, logs);
    _detailsSubject.add(details);
  }
}
