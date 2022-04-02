import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class BuyPropertyUseCase {
  final BuyingService _repository;

  BuyPropertyUseCase(this._repository);

  Future<Result<BuyingState>> call(PropertyOffer offer) => _repository.buyProperty(offer);
}
