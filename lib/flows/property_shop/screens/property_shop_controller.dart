import 'package:alpaka_clicker/flows/property_shop/domain/properties_repository.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/property_model.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'property_shop_controller.g.dart';

@injectable
class PropertyShopController = PropertyShopControllerBase with _$PropertyShopController;

abstract class PropertyShopControllerBase with Store {
  final PropertiesRepository _test;

  PropertyShopControllerBase(this._test) {
    _test.getPropertiesList().listen((event) {
      event.onSuccess((value) => models = value);
    });
  }

  @observable
  List<PropertyModel> models = List.empty();
}
