import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:rxdart/subjects.dart';

class PropertiesServiceImpl implements PropertiesService {
  final List<Property> _properties;

  PropertiesServiceImpl(this._properties);

  late final BehaviorSubject<List<Property>> _displaySubject = BehaviorSubject.seeded(_properties);

  @override
  List<Property> get properties => _properties.toList();

  @override
  Stream<List<Property>> listenToProperties() => _displaySubject.stream;

  @override
  Future<void> increasePropertyCount(PropertyOffer offer) async {
    _properties.firstWhere((property) => property.key == offer.key).addPurchased(offer.count);
    _displaySubject.add(properties);
  }

  @override
  Future<void> upgradeProperty() {
    // TODO: implement upgradeProperty
    throw UnimplementedError();
  }
}
