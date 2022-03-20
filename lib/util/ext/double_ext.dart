extension DoubleExt on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));

  double trimToOnePlaceBeforePoint() {
    final initialString = toString().replaceAll(".", "");
    final beforePoint = initialString.substring(0, 1);
    final afterPoint = initialString.substring(1, initialString.length);
    final stringWithOnePlace = beforePoint + "." + afterPoint;
    return double.parse(stringWithOnePlace);
  }
}
