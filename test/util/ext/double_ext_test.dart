import 'package:alpaka_clicker/util/ext/double_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Only one point extension test", () {
    const underTest = 12345.6789;
    final result = underTest.trimToOnePlaceBeforePoint();
    expect(result, 1.23456789);
  });
}
