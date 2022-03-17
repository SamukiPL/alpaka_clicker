import 'package:alpaka_clicker/clicker_base/money/domain/get_displayable_money_use_case.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../testUtils/expect_throw.dart';
import '../../../../testUtils/mocks.mocks.dart';

void main() {
  setUp(() {
    resetMockitoState();
  });
  final mock = MockMoneyService();
  test("MoneyRepository return Stream and emits \"123.456 AA\"", () async {
    final subject = PublishSubject<Result<String>>();
    const value = "123.456 AA";
    when(mock.getDisplayableMoney()).thenAnswer((_) => subject.cast());
    final underTest = GetDisplayableMoneyUseCase(mock);
    underTest().listen((result) {
      expect(result.isSuccess(), true);
      expect((result as Success).value, value);
    });
    subject.add(Success(value));
  });

  test("MoneyRepository return Stream and emits Failure with FormatException", () async {
    final subject = PublishSubject<Result<String>>();
    when(mock.getDisplayableMoney()).thenAnswer((_) => subject);
    final underTest = GetDisplayableMoneyUseCase(mock);
    underTest().listen((result) {
      expect(result.isFailure(), true);
      expect((result as Failure).error.runtimeType, FormatException);
    });
    subject.add(Failure(const FormatException()));
  });

  test("MoneyRepository throws Exception", () async {
    when(mock.getDisplayableMoney()).thenAnswer((_) => throw const FormatException());
    final underTest = GetDisplayableMoneyUseCase(mock);
    expectThrow(underTest, FormatException);
  });
}
