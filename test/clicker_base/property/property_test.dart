import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testUtils/mocked_models.dart';

void main() {
  test("Property has key", () {
    const expectedKey = "key";
    final underTest = Property(
        key: expectedKey,
        name: "name",
        count: 1,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: emptyCurrency());
    expect(underTest.key, expectedKey);
  });

  test("Property has name", () {
    const expectedName = "Guma Turbo";
    final underTest = Property(
        key: "key",
        name: expectedName,
        count: 1,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: emptyCurrency());
    expect(underTest.name, expectedName);
  });

  test("Property has count", () {
    const expectedKey = 21;
    final underTest = Property(
        key: "key",
        name: "name",
        count: expectedKey,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: emptyCurrency());
    expect(underTest.count, expectedKey);
  });

  test("Property has incrementation", () {
    const expectedKey = 21;
    final underTest = Property(
        key: "key",
        name: "name",
        count: expectedKey,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: emptyCurrency());
    expect(underTest.baseIncrementation, currency(1.07, 0));
  });

  test("Property has price", () {
    final expectedPrice = currency(1.0, 1);
    final underTest = Property(
        key: "key",
        name: "name",
        count: 1,
        baseIncrementation: currency(1.07, 0),
        basePrice: expectedPrice,
        baseInterest: emptyCurrency());
    expect(underTest.basePrice, expectedPrice);
  });

  test("Property has interest", () {
    final expectedInterest = currency(1.0, 1);
    final underTest = Property(
        key: "key",
        name: "name",
        count: 1,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: expectedInterest);
    expect(underTest.baseInterest, expectedInterest);
  });

  test("Add to property count new purchased properties", () {
    const startCount = 1;
    const purchasedCount = 7;
    final underTest = Property(
        key: "key",
        name: "name",
        count: startCount,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: emptyCurrency());
    underTest.addPurchased(purchasedCount);
    expect(underTest.count, startCount + purchasedCount);
  });

  test("Multiply base interest after some upgrade for property was bought", () {
    const interestMultiplier = 1.2;
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: "key",
        name: "name",
        count: 1,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: baseInterest);
    underTest.multiplyInterest(interestMultiplier);
    expect(underTest.baseInterest, baseInterest.multiplyByDouble(interestMultiplier));
  });

  test("Property returns interest produced by all count", () {
    const count = 8;
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: "key",
        name: "name",
        count: count,
        baseIncrementation: currency(1.07, 0),
        basePrice: emptyCurrency(),
        baseInterest: baseInterest);
    expect(underTest.getCurrentInterest(), baseInterest.multiplyByDouble(count.toDouble()));
  });

  test("Property returns price for iteration = 1 with some formula", () {
    final increment = currency(1.07, 0);
    final basePrice = currency(1, 1);
    final underTest = Property(
        key: "key",
        name: "name",
        count: 0,
        baseIncrementation: increment,
        basePrice: basePrice,
        baseInterest: emptyCurrency());

    const firstIteration = 1;
    final price = underTest.generatePrice(firstIteration);
    expect(price, basePrice * increment.powByExponent(firstIteration));
  });

  test("Property returns price for iteration = 10 with some formula", () {
    final increment = currency(1.07, 0);
    final basePrice = currency(1, 1);
    final underTest = Property(
        key: "key",
        name: "name",
        count: 0,
        baseIncrementation: increment,
        basePrice: basePrice,
        baseInterest: emptyCurrency());
    const tenIteration = 10;
    final priceTen = underTest.generatePrice(tenIteration);
    expect(priceTen, basePrice * increment.powByExponent(tenIteration));
  });

  test("Property returns price for iteration = 100 with some formula", () {
    final increment = currency(1.07, 0);
    final basePrice = currency(1, 1);
    final underTest = Property(
        key: "key",
        name: "name",
        count: 0,
        baseIncrementation: increment,
        basePrice: basePrice,
        baseInterest: emptyCurrency());

    const hundredIteration = 100;
    final priceHundred = underTest.generatePrice(hundredIteration);
    expect(priceHundred, basePrice * increment.powByExponent(hundredIteration));
  });

  test("Property returns offer with only 1 offerCount as default and first price is only basePrice", () {
    const key = "key";
    const initialCount = 0;
    final baseIncrementation = Currency(value: 4.0, power: 0);
    final basePrice = currency(1, 10);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    final offer = underTest.getOffer();
    expect(offer.key, key);
    expect(offer.count, 1);
    expect(offer.price, basePrice);
    expect(offer.interest, baseInterest);
  });

  test("Base price is 1, incrementation 2 and I want to buy second one", () {
    const key = "key";
    const initialCount = 1;
    final baseIncrementation = Currency(value: 2.0, power: 0);
    final basePrice = currency(1, 0);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    final offer = underTest.getOffer();
    expect(offer.key, key);
    expect(offer.count, 1);
    expect(offer.price.value, 2);
    expect(offer.price.power, 0);
    expect(offer.interest, baseInterest);
  });

  test("Base price is 1, incrementation 2 and I want to buy third one", () {
    const key = "key";
    const initialCount = 2;
    final baseIncrementation = Currency(value: 2.0, power: 0);
    final basePrice = currency(1, 0);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    final offer = underTest.getOffer();
    expect(offer.key, key);
    expect(offer.count, 1);
    expect(offer.price.value, 4);
    expect(offer.price.power, 0);
    expect(offer.interest, baseInterest);
  });

  test("Base price is 1, incrementation 2 and I want to buy ten", () {
    const key = "key";
    const initialCount = 0;
    final baseIncrementation = Currency(value: 2.0, power: 0);
    final basePrice = currency(1, 0);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    const offerCount = 10;

    final offer = underTest.getOffer(offerCount: offerCount);
    expect(offer.key, key);
    expect(offer.count, offerCount);
    expect(offer.price.value, 1.023);
    expect(offer.price.power, 3);
    expect(offer.interest, baseInterest.multiplyByDouble(offerCount.toDouble()));
  });

  test("Base price is 1, incrementation 2 and I want to buy hundred", () {
    const key = "key";
    const initialCount = 0;
    final baseIncrementation = Currency(value: 2.0, power: 0);
    final basePrice = currency(1, 0);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    const offerCount = 100;

    final offer = underTest.getOffer(offerCount: offerCount);
    expect(offer.key, key);
    expect(offer.count, offerCount);
    expect(offer.price.value, 1.267650600229);
    expect(offer.price.power, 30);
    expect(offer.interest, baseInterest.multiplyByDouble(offerCount.toDouble()));
  });

  test("On offers price ceil is used so that it will be always natural number", () {
    const key = "key";
    const initialCount = 0;
    final baseIncrementation = Currency(value: 2.0, power: 0);
    final basePrice = currency(3.21046487988, 3);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    const offerCount = 1;

    final offer = underTest.getOffer(offerCount: offerCount);
    expect(offer.price.value, 3.210);
    expect(offer.price.power, 3);
  });

  test("Base price is 1, incrementation 2 and I want to buy 5 when I already have 5", () {
    const key = "key";
    const initialCount = 5;
    final baseIncrementation = Currency(value: 2.0, power: 0);
    final basePrice = currency(1, 0);
    final baseInterest = currency(1.0, 2);
    final underTest = Property(
        key: key,
        name: "name",
        count: initialCount,
        baseIncrementation: baseIncrementation,
        basePrice: basePrice,
        baseInterest: baseInterest);

    const offerCount = 5;

    final offer = underTest.getOffer(offerCount: offerCount);
    expect(offer.key, key);
    expect(offer.count, offerCount);
    expect(offer.price.value, 9.92);
    expect(offer.price.power, 2);
    expect(offer.interest, baseInterest.multiplyByDouble(offerCount.toDouble()));
  });
}
