import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/level_up_status.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class LevelUpAttributeUseCase {
  final CharacterDetailsRepository _repository;

  LevelUpAttributeUseCase(this._repository);

  Future<Result<LevelUpStatus>> call(AttributeTag tag) => _repository.levelUpAttribute(tag);
}
