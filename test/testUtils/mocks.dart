import 'dart:math';

import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_level_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_main_attribute_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_personalty_level_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/attribute_level_range_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/enemy_generator.dart';
import 'package:alpaka_clicker/character_base/character/data/player_generator.dart';
import 'package:alpaka_clicker/character_base/character/domain/character_service.dart';
import 'package:alpaka_clicker/character_base/personalty/domain/personalties_service.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buy_property_use_case.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';
import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:alpaka_clicker/clicker_base/money/data/store_clerc.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/get_displayable_interest_per_second_use_case.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/mappers/character_to_character_info_mapper.dart';
import 'package:alpaka_clicker/flows/character_details/mappers/to_personalty_model_mapper.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/attribute_probability_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/damage_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/health_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/fight_director.dart';
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
  DamageCalculator,
  HealthCalculator,
  AttributeProbabilityCalculator,
  FightDirector,
  Random,
  CharacterDetailsRepository,
  PersonaltiesService,
  PlayerGenerator,
  CharacterService,
  CharacterToCharacterInfoMapper,
  ToPersonaltyModelMapper,
  AttributeLevelRangeProbabilityCalculator,
  GradeProbabilityCalculator,
  EnemyGenerator,
  EnemyLevelProbabilityCalculator,
  EnemyMainAttributeProbabilityCalculator,
  EnemyPersonaltyLevelProbabilityCalculator
])
void main() {}
