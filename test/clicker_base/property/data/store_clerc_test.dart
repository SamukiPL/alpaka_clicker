import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/flows/property_shop/data/store_clerc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testUtils/mocked_models.dart';

void main() {
  test("Store clerc takes current prices", () {
    final offers = [
      PropertyOffer(key: "", count: 0, price: currency(5, 5), interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: currency(5, 0), interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: currency(5, 2), interest: emptyCurrency()),
    ];
    final underTest = StoreClerc();
    expect(underTest.getCurrentPricesQueue.isEmpty, true);
    underTest.updateCurrentOffers(offers);
    expect(underTest.getCurrentPricesQueue.isEmpty, false);
  });

  test("Store clerc takes current prices and remove previous items", () {
    final offers = [
      PropertyOffer(key: "", count: 0, price: currency(5, 5), interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: currency(5, 0), interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: currency(5, 2), interest: emptyCurrency()),
    ];
    final onlyTwoOffers = [
      PropertyOffer(key: "", count: 0, price: currency(5, 5), interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: currency(5, 0), interest: emptyCurrency()),
    ];
    final underTest = StoreClerc();
    underTest.updateCurrentOffers(offers);
    expect(underTest.getCurrentPricesQueue.length, offers.length);
    underTest.updateCurrentOffers(onlyTwoOffers);
    expect(underTest.getCurrentPricesQueue.length, onlyTwoOffers.length);
  });

  test("Store clerc sorts prices from small to big", () {
    final smallest = currency(5, 0);
    final mid = currency(5, 2);
    final biggest = currency(5, 5);
    final offers = [
      PropertyOffer(key: "", count: 0, price: biggest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: smallest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: mid, interest: emptyCurrency()),
    ];

    final underTest = StoreClerc();
    underTest.updateCurrentOffers(offers);
    final prices = underTest.getCurrentPricesQueue;
    expect(prices.removeFirst(), smallest);
    expect(prices.removeFirst(), mid);
    expect(prices.removeFirst(), biggest);
  });

  test("Store clerc returns false if cannot afford anything", () {
    final smallest = currency(5, 0);
    final mid = currency(5, 2);
    final biggest = currency(5, 5);
    final offers = [
      PropertyOffer(key: "", count: 0, price: biggest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: smallest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: mid, interest: emptyCurrency()),
    ];

    final underTest = StoreClerc();
    underTest.updateCurrentOffers(offers);
    expect(underTest.canAffordNewItem(emptyCurrency()), false);
  });

  test("Store clerc returns true if can afford something", () {
    final smallest = currency(5, 0);
    final mid = currency(5, 2);
    final biggest = currency(5, 5);
    final offers = [
      PropertyOffer(key: "", count: 0, price: biggest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: smallest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: mid, interest: emptyCurrency()),
    ];

    final underTest = StoreClerc();
    underTest.updateCurrentOffers(offers);
    expect(underTest.canAffordNewItem(smallest), true);
  });

  test("Store clerc removes prices that you can afford", () {
    final smallest = currency(5, 0);
    final mid = currency(5, 2);
    final biggest = currency(5, 5);
    final offers = [
      PropertyOffer(key: "", count: 0, price: biggest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: smallest, interest: emptyCurrency()),
      PropertyOffer(key: "", count: 0, price: mid, interest: emptyCurrency()),
    ];

    final underTest = StoreClerc();
    underTest.updateCurrentOffers(offers);
    underTest.canAffordNewItem(biggest);
    expect(underTest.getCurrentPricesQueue.isEmpty, true);
  });

  test("Store clerc returns false if there are not prices at the moment", () {
    final underTest = StoreClerc();
    expect(underTest.canAffordNewItem(emptyCurrency()), false);
  });
}
