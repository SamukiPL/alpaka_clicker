import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class BuyPersonaltyUseCase {
  final CharacterDetailsRepository _repository;

  BuyPersonaltyUseCase(this._repository);

  Future<void> call(PersonaltyOffer offer) => _repository.buyPersonalityLevel(offer);
}
