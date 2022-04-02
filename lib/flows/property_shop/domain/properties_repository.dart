import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

abstract class PropertiesRepository {
  Stream<Result<List<PropertyModel>>> getPropertiesList();
  Future<void> changeBuyAmount(BuyAmount amount);
}
