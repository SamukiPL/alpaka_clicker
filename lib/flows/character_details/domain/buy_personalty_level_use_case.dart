import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';

class BuyPersonaltyLevelUseCase {
  final BuyingService _buyingService;

  BuyPersonaltyLevelUseCase(this._buyingService);

  Future<void> call(PersonaltyOffer offer) => _buyingService.buyPersonalty(offer);
}
