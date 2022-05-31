import 'dart:async';

import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/flows/character_details/domain/buy_personalty_level_use_case.dart';
import 'package:alpaka_clicker/flows/character_details/domain/get_character_info_use_case.dart';
import 'package:alpaka_clicker/flows/character_details/domain/get_personalties_use_case.dart';
import 'package:alpaka_clicker/flows/character_details/domain/level_up_attribute_use_case.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/attribute_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'character_details_controller.g.dart';

@injectable
class CharacterDetailsController = _CharacterDetailsControllerBase with _$CharacterDetailsController;

abstract class _CharacterDetailsControllerBase with Store {
  final GetCharacterInfoUseCase _characterInfoUseCase;
  final GetPersonaltiesUseCase _getPersonaltiesUseCase;
  final BuyPersonaltyLevelUseCase _buyPersonaltyLevelUseCase;
  final LevelUpAttributeUseCase _levelUpAttributeUseCase;

  late final StreamSubscription _offersSubscription;

  _CharacterDetailsControllerBase(this._characterInfoUseCase, this._getPersonaltiesUseCase,
      this._buyPersonaltyLevelUseCase, this._levelUpAttributeUseCase);

  @observable
  bool isLoading = true;

  @observable
  CharacterInfoModel? characterInfoModel;

  @observable
  List<PersonaltyModel> personalties = [];

  @action
  Future<void> initialize() async {
    _getCharacterInfo();
    _offersSubscription = _getPersonaltiesUseCase().listen((event) {
      event.onSuccess((value) => personalties = value);
    });
    isLoading = false;
  }

  @action
  Future<void> _getCharacterInfo() async {
    characterInfoModel = await _characterInfoUseCase();
  }

  Future<void> buyPersonalty(PersonaltyOffer offer) async {
    //TODO handle success and error for better UX
    await _buyPersonaltyLevelUseCase(offer);
  }

  Future<void> levelUpAttribute(AttributeModel attribute) async {
    final result = await _levelUpAttributeUseCase(attribute.tag);
    result.onSuccess((value) {
      _getCharacterInfo();
    });
  }

  void dispose() {
    _offersSubscription.cancel();
  }
}
