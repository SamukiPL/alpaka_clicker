import 'package:alpaka_clicker/clicker_base/property/data/properties_service_impl.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testUtils/mocked_models.dart';

void main() {
  test("Property services gets properties list by constructor", () {
    List<Property> list = [];
    PropertiesServiceImpl(list);
  });

  test("Property services returns current properties list async", () async {
    List<Property> list = [];
    final underTest = PropertiesServiceImpl(list);
    underTest.listenToProperties().listen(expectAsync1((returned) {
      expect(returned, list);
    }, count: 1));
  });

  test("Update property count by key", () async {
    const sameKey = "key";
    List<Property> list = [Property(key: sameKey, name: "Name", count: 0, baseIncrementation: emptyCurrency(), basePrice: emptyCurrency(), baseInterest: emptyCurrency())];
    final offer = PropertyOffer(key: sameKey, count: 5, price: emptyCurrency(), interest: emptyCurrency());
    final underTest = PropertiesServiceImpl(list);
    underTest.increasePropertyCount(offer);

    underTest.listenToProperties().listen(expectAsync1((returned) {
      expect(returned, list);
      final properties = returned.first;
      expect(properties.count, offer.count);
    }, count: 1));
  });
}
