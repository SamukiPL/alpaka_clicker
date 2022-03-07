import 'package:alpaka_clicker/money/currency.dart';
import 'package:alpaka_clicker/money/data/money_repository_impl.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/mocks.mocks.dart';

void main() {
  final bank = MockBank();
  final beautifier = MockCurrencyBeautifier();
  setUp(() {
    resetMockitoState();
  });

  test("Bank payInterest gets invoked", () async {
    final underTest = MoneyRepositoryImpl(bank, beautifier);
    underTest.payInterest();
    verify(bank.payInterest()).called(1);
  });

  test("Bank paySalary gets invoked", () async {
    final underTest = MoneyRepositoryImpl(bank, beautifier);
    underTest.paySalary();
    verify(bank.paySalary()).called(1);
  });

  test("UnderTest returns stream with Result<String> and emits Success when underTest.payInterest is invoked", () async {
    final underTest = MoneyRepositoryImpl(bank, beautifier);

    final expectedCurrency = Currency(value: 1.23456, power: 5);
    const expectedString = "123.456";

    when(bank.getMoney()).thenReturn(expectedCurrency);
    when(beautifier.beautifyCurrency(any)).thenReturn(expectedString);

    underTest.getDisplayableMoney().listen(expectAsync1((event) {
      expect(event.runtimeType, Success<String>);
      expect((event as Success<String>).value, expectedString);
      verify(bank.getMoney()).called(1);
      verify(beautifier.beautifyCurrency(expectedCurrency)).called(1);
    }, max: 1));
    underTest.payInterest();
  });

  test("UnderTest returns stream with Result<String> and emits Success when underTest.paySalary is invoked", () async {
    final underTest = MoneyRepositoryImpl(bank, beautifier);

    final expectedCurrency = Currency(value: 1.23456, power: 5);
    const expectedString = "123.456";

    when(bank.getMoney()).thenReturn(expectedCurrency);
    when(beautifier.beautifyCurrency(any)).thenReturn(expectedString);

    underTest.getDisplayableMoney().listen(expectAsync1((event) {
      expect(event.runtimeType, Success<String>);
      expect((event as Success<String>).value, expectedString);
      verify(bank.getMoney()).called(1);
      verify(beautifier.beautifyCurrency(expectedCurrency)).called(1);
    }, max: 1));
    underTest.paySalary();
  });

  test("UnderTest returns stream and emits failure when bank fails", () async {
    final underTest = MoneyRepositoryImpl(bank, beautifier);

    when(bank.getMoney()).thenThrow(const FormatException());
    when(beautifier.beautifyCurrency(any));

    underTest.getDisplayableMoney().listen(expectAsync1((event) {
      expect(event.runtimeType, Failure<String>);
      expect((event as Failure<String>).error.runtimeType, FormatException);
      verify(bank.getMoney()).called(1);
    }, max: 1));
    underTest.payInterest();
  });

  test("UnderTest returns stream and emits failure when beautifier fails", () async {
    final underTest = MoneyRepositoryImpl(bank, beautifier);

    final expectedCurrency = Currency(value: 1.23456, power: 5);

    when(bank.getMoney()).thenReturn(expectedCurrency);
    when(beautifier.beautifyCurrency(any)).thenThrow(const FormatException());

    underTest.getDisplayableMoney().listen(expectAsync1((event) {
      expect(event.runtimeType, Failure<String>);
      expect((event as Failure<String>).error.runtimeType, FormatException);
      verify(bank.getMoney()).called(1);
      verify(beautifier.beautifyCurrency(expectedCurrency)).called(1);
    }, max: 1));
    underTest.paySalary();
  });
}
