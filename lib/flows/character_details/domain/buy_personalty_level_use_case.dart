import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';

class BuyPersonaltyLevelUseCase {
  final CharacterDetailsRepository _repository;

  BuyPersonaltyLevelUseCase(this._repository);

  Future<void> call(PersonaltyOffer offer) => _repository.buyPersonalityLevel(offer);
}
