import 'package:alpaka_clicker/util/ext/double_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Only one point extension test", () {
    const underTest = 12345.6789;
    final result = underTest.trimToOnePlaceBeforePoint();
    expect(result, 1.23456789);
  });

  test("Trim all numbers after point with default 0", () {
    const underTest = 1.123456;
    final result = underTest.trimAfterPoint();
    expect(result, 1);
  });

  test("Trim all numbers after point with given place", () {
    const underTest = 1.123456;
    final result = underTest.trimAfterPoint(place: 2);
    expect(result, 1.12);
  });

  test("Trim all numbers after point even if place to trim is further than last number", () {
    const underTest = 1.123456;
    final result = underTest.trimAfterPoint(place: 20);
    expect(result, 1.123456);
  });
}
