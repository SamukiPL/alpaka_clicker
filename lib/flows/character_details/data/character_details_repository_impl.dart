import 'package:alpaka_clicker/character_base/character/domain/character_service.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/personalty/domain/personalties_service.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/data/store_clerc.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:alpaka_clicker/flows/character_details/mappers/character_to_character_info_mapper.dart';
import 'package:alpaka_clicker/flows/character_details/mappers/to_personalty_model_mapper.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: CharacterDetailsRepository)
class CharacterDetailsRepositoryImpl implements CharacterDetailsRepository {
  final MoneyService _moneyService;
  final CharacterService _characterService;
  final PersonaltiesService _personaltiesService;
  final StoreClerc _storeClerc;
  final CharacterToCharacterInfoMapper _characterMapper;
  final ToPersonaltyModelMapper _personaltyModelMapper;

  CharacterDetailsRepositoryImpl(
    this._moneyService,
    this._characterService,
    this._personaltiesService,
    this._storeClerc,
    this._characterMapper,
    this._personaltyModelMapper,
  );

  @override
  Future<CharacterInfoModel> getCharacterInfo() async {
    final character = _characterService.playerCharacter;
    return _characterMapper(character);
  }

  @override
  Stream<Result<List<PersonaltyModel>>> getPersonaltiesList() => CombineLatestStream.combine2(
        _moneyService.getDepositedMoney(),
        _personaltiesService.listenToPersonalties(),
        (Currency a, List<Personalty> b) => Pair(a, b),
      )
          .distinct(
        (previous, next) => !(_storeClerc.canAffordNewItem(next.first)),
      )
          .map((pair) {
        final character = _characterService.playerCharacter;
        final money = pair.first;
        final personalties = pair.last;

        final personaltyWithOfferMap =
            personalties.asMap().map((index, personalty) => MapEntry(personalty, personalty.getOffer()));
        _storeClerc.updateCurrentOffers(personaltyWithOfferMap.values, money);
        final models = personaltyWithOfferMap
            .map(
              (personalty, offer) => MapEntry(personalty, _personaltyModelMapper(money, character, personalty, offer)),
            )
            .values
            .toList();
        return Result.success(models);
      }).onErrorReturnWith((error, stackTrace) => (error is Exception) ? Result.failure(error) : throw error);

  @override
  Future<Result<void>> levelUpAttribute(AttributeTag tag) {
    // TODO: implement levelUpAttribute
    throw UnimplementedError();
  }
}
