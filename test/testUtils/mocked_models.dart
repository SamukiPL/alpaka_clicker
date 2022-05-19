import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:alpaka_clicker/character_base/character.dart';
import 'package:alpaka_clicker/character_base/character_level.dart';
import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';

Bank emptyBank() => Bank(emptyCurrency(), emptyCurrency(), emptyCurrency());

Bank bankWithMoney(double value, int power) => Bank(currency(value, power), emptyCurrency(), emptyCurrency());

Bank bankWithInterest(double value, int power) => Bank(emptyCurrency(), emptyCurrency(), currency(value, power));

Bank bankWithSalary(double value, int power) => Bank(emptyCurrency(), currency(value, power), emptyCurrency());

Currency emptyCurrency() => Currency(value: 0.0, power: 0);

Currency currency(double value, int power) => Currency(value: value, power: power);

Property emptyProperty() => Property(
    key: "",
    name: "",
    count: 0,
    baseIncrementation: emptyCurrency(),
    basePrice: emptyCurrency(),
    baseInterest: emptyCurrency());

PropertyOffer emptyPropertyOffer() =>
    PropertyOffer(key: "", count: 1, price: emptyCurrency(), interest: emptyCurrency());

PropertyModel emptyPropertyModel() => PropertyModel(
    name: "",
    displayablePrice: "",
    displayableIncome: "",
    propertyCount: 0,
    canBuy: false,
    offer: emptyPropertyOffer());

PropertyModel propertyModel(
        {String name = "",
        String displayablePrice = "",
        String displayableIncome = "",
        int count = 1,
        bool canBuy = false,
        PropertyOffer? offer}) =>
    PropertyModel(
        name: name,
        displayablePrice: displayablePrice,
        displayableIncome: displayableIncome,
        propertyCount: count,
        canBuy: canBuy,
        offer: offer ?? emptyPropertyOffer());

Character emptyCharacter() {
  final characterLevel = CharacterLevel(level: 1, experienceStrategy: 1, experience: 1);
  final rock = Rock(1, Grade.a);
  final paper = Paper(1, Grade.s);
  final scissors = Scissors(1, Grade.d);
  final knowledge = Knowledge(1, Grade.f);
  return Character("Test", characterLevel, rock, paper, scissors, knowledge);
}

Probability emptyProbability() => Probability(1, {});
