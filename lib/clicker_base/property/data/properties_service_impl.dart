import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:rxdart/subjects.dart';

class PropertiesServiceImpl implements PropertiesService {
  final List<Property> _properties;

  PropertiesServiceImpl(this._properties);

  late final PublishSubject<List<Property>> _displaySubject = PublishSubject(onListen: () {
    _displaySubject.add(_properties);
  });

  @override
  List<Property> getProperties() => _properties;

  @override
  Stream<List<Property>> listenToProperties() => _displaySubject.stream;

  @override
  Future<void> increasePropertyCount(PropertyOffer offer) async {
    _properties.firstWhere((property) => property.key == offer.key).addPurchased(offer.count);
    _displaySubject.add(_properties);
  }

  @override
  Future<void> upgradeProperty() {
    // TODO: implement upgradeProperty
    throw UnimplementedError();
  }
}
