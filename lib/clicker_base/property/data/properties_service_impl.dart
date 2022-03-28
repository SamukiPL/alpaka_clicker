import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';

class PropertiesServiceImpl implements PropertiesService {
  final List<Property> _properties;

  PropertiesServiceImpl(this._properties);

  @override
  Stream<List<Property>> getProperties() async* {
    yield _properties;
  }

  @override
  Future<void> increasePropertyCount(PropertyOffer offer) async {
    _properties.firstWhere((property) => property.key == offer.key).addPurchased(offer.count);
  }

  @override
  Future<void> upgradeProperty() {
    // TODO: implement upgradeProperty
    throw UnimplementedError();
  }
}
