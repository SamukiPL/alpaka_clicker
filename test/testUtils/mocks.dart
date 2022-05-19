import 'dart:math';

import 'package:alpaka_clicker/clicker_base/buying/domain/buy_property_use_case.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';
import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/get_displayable_interest_per_second_use_case.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/damage_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/dice_roller.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/health_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/fight_director.dart';
import 'package:alpaka_clicker/flows/property_shop/data/store_clerc.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/change_buy_amount_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/get_offers_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/properties_repository.dart';
import 'package:alpaka_clicker/flows/property_shop/mappers/to_property_model_mapper.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MoneyService,
  Bank,
  CurrencyBeautifier,
  PropertiesService,
  StoreClerc,
  BuyingService,
  ToPropertyModelMapper,
  PropertiesRepository,
  ChangeBuyAmountUseCase,
  GetOffersUseCase,
  BuyPropertyUseCase,
  GetDisplayableInterestPerSecondUseCase,
  DiceRoller,
  DamageCalculator,
  HealthCalculator,
  ProbabilityCalculator,
  FightDirector,
  Random
])
void main() {}
