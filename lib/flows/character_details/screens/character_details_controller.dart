import 'package:alpaka_clicker/flows/character_details/domain/get_character_info_use_case.dart';
import 'package:alpaka_clicker/flows/character_details/domain/get_personalties_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'character_details_controller.g.dart';

@injectable
class CharacterDetailsController = _CharacterDetailsControllerBase with _$CharacterDetailsController;

abstract class _CharacterDetailsControllerBase with Store {
  final GetCharacterInfoUseCase _characterInfoUseCase;
  final GetPersonaltiesUseCase _getPersonaltiesUseCase;

  _CharacterDetailsControllerBase(this._characterInfoUseCase, this._getPersonaltiesUseCase);
}
