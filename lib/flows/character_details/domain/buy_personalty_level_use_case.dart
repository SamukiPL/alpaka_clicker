import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class BuyPersonaltyLevelUseCase {
  final BuyingService _buyingService;

  BuyPersonaltyLevelUseCase(this._buyingService);

  Future<Result<BuyingState>> call(PersonaltyOffer offer) => _buyingService.buyPersonalty(offer);
}
