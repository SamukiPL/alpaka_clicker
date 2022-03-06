import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/money/currency_beautifier.dart';
import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MoneyRepository,
  Bank,
  CurrencyBeautifier
])
void main() {}
