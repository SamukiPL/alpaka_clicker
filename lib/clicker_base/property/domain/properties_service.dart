import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';

abstract class PropertiesService {
  Stream<List<Property>> getProperties();
  Future<void> increasePropertyCount(PropertyOffer offer);
  Future<void> upgradeProperty();
}
