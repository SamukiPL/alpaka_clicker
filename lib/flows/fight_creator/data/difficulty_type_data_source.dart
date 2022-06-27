import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';

@injectable
class DifficultyTypeDataSource {
  final Character _character;

  DifficultyTypeDataSource(this._character);

  DifficultyModel getModel(DifficultyType type) {
    switch (type) {
      case DifficultyType.easy:
        return _getEasyModel();
      case DifficultyType.normal:
        return _getNormalModel();
      case DifficultyType.hard:
        return _getHardModel();
    }
  }

  DifficultyModel _getEasyModel() => DifficultyModel(DifficultyType.easy, Range(_character.level - 3, _character.level - 1), 10, 0.37, 0.1);

  DifficultyModel _getNormalModel() => DifficultyModel(DifficultyType.normal, Range(_character.level - 2, _character.level + 4), 10, 0.21, 0.1);

  DifficultyModel _getHardModel() => DifficultyModel(DifficultyType.hard, Range(_character.level + 2, _character.level + 6), 10, 0.13, 0.1);
}
