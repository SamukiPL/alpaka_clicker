import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/money/currency.dart';
import 'package:alpaka_clicker/money/currency_beautifier.dart';
import 'package:alpaka_clicker/money/data/money_repository_impl.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'money_repository_impl_test.mocks.dart';

@GenerateMocks([Bank, CurrencyBeautifier])
void main() {
  final bank = MockBank();
  final beautifier = MockCurrencyBeautifier();
  setUp(() {
    resetMockitoState();
  });

  test("Bank return currency and beautifier returns String", () {
    final underTest = MoneyRepositoryImpl(bank, beautifier);

    final expectedCurrency = Currency(value: 1.23456, power: 5);
    const expectedString = "123.456";

    when(bank.getMoney()).thenReturn(expectedCurrency);
    when(beautifier.beautifyCurrency(any)).thenReturn(expectedString);

    final returned = underTest.getDisplayableMoney();
    expect(returned.isSuccess(), true);
    expect((returned as Success).value, expectedString);
    verify(bank.getMoney()).called(1);
    verify(beautifier.beautifyCurrency(expectedCurrency)).called(1);
  });

  test("Bank throws and beautifier returns String", () {
    final underTest = MoneyRepositoryImpl(bank, beautifier);
    when(bank.getMoney()).thenThrow(const FormatException());
    when(beautifier.beautifyCurrency(any));

    final returned = underTest.getDisplayableMoney();
    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);
    verify(bank.getMoney()).called(1);
    verifyNever(beautifier.beautifyCurrency(any));
  });

  test("Bank return currency and beautifier throws", () {
    final underTest = MoneyRepositoryImpl(bank, beautifier);

    final expectedCurrency = Currency(value: 1.23456, power: 5);

    when(bank.getMoney()).thenReturn(expectedCurrency);
    when(beautifier.beautifyCurrency(any)).thenThrow(const FormatException());

    final returned = underTest.getDisplayableMoney();
    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);
    verify(bank.getMoney()).called(1);
    verify(beautifier.beautifyCurrency(expectedCurrency)).called(1);
  });
}
