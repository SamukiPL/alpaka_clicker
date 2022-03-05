import 'package:alpaka_clicker/money/domain/get_displayable_money_use_case.dart';
import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../testUtils/expect_throw.dart';
import 'get_displayable_money_use_case_test.mocks.dart';

@GenerateMocks([MoneyRepository])
void main() {
  final mock = MockMoneyRepository();
  test("MoneyRepository return Success with \"123.456 AA\"", () {
    const value = "123.456 AA";
    when(mock.getDisplayableMoney()).thenReturn(Success(value));
    final underTest = GetDisplayableMoneyUseCase(mock);
    final returned = underTest();

    expect(returned.isSuccess(), true);
    expect((returned as Success).value, value);

    reset(mock);
  });

  test("MoneyRepository return Failure with Exception", () {
    when(mock.getDisplayableMoney()).thenReturn(Failure(const FormatException()));
    final underTest = GetDisplayableMoneyUseCase(mock);
    final returned = underTest();

    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);

    reset(mock);
  });

  test("MoneyRepository throws Exception", () {
    when(mock.getDisplayableMoney()).thenThrow(const FormatException());
    final underTest = GetDisplayableMoneyUseCase(mock);
    expectThrow(underTest, FormatException);
  });
}
