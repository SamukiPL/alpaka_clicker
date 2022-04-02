import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/properties_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeBuyAmountUseCase {
  final PropertiesRepository _repository;

  ChangeBuyAmountUseCase(this._repository);

  Future<void> call(BuyAmount amount) => _repository.changeBuyAmount(amount);
}
