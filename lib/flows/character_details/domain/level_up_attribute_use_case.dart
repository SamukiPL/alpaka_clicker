import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LevelUpAttributeUseCase {
  final CharacterDetailsRepository _repository;

  LevelUpAttributeUseCase(this._repository);

  Future<void> call(AttributeTag tag) => _repository.levelUpAttribute(tag);
}
