import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';

abstract class PropertiesService {
  List<Property> getProperties();
  Stream<List<Property>> listenToProperties();
  Future<void> increasePropertyCount(PropertyOffer offer);
  Future<void> upgradeProperty();
}
