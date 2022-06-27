import 'package:alpaka_clicker/flows/fight_creator/data/difficulty_type_data_source.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/fight_creator_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@Singleton(as: FightCreatorRepository)
class FightCreatorRepositoryImpl implements FightCreatorRepository {
  final DifficultyTypeDataSource _difficultyTypeDataSource;

  FightCreatorRepositoryImpl(this._difficultyTypeDataSource);

  late final BehaviorSubject<DifficultyModel> _difficultySubject = BehaviorSubject.seeded(_difficultyTypeDataSource.getModel(DifficultyType.normal));

  @override
  Stream<DifficultyModel> observeDifficulty() => _difficultySubject.stream;

  @override
  Future<void> changeDifficulty(DifficultyType type) async {
    final model = _difficultyTypeDataSource.getModel(type);
    _difficultySubject.add(model);
  }

}
