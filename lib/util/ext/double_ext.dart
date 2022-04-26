import 'dart:math';

extension DoubleExt on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));

  double trimToOnePlaceBeforePoint() {
    final initialString = toString().replaceAll(".", "");
    final beforePoint = initialString.substring(0, 1);
    final afterPoint = initialString.substring(1, initialString.length);
    final stringWithOnePlace = beforePoint + "." + afterPoint;
    return double.parse(stringWithOnePlace);
  }

  double trimAfterPoint({int place = 0}) {
    final initialString = toString();
    final correctedInitialCutIndex = initialString.indexOf(".") + 1;
    final cutIndex = min(correctedInitialCutIndex + place, initialString.length);
    final trimmedString = initialString.substring(0, cutIndex);
    return double.parse(trimmedString);
  }
}
