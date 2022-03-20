class CannotSubtractException implements Exception {}

class CannotMultiplyException implements Exception {
  @override
  String toString() {
    return "CannotMultiplyException: multiplier must be higher or equal 1";
  }
}

class CannotPowException implements Exception {
  @override
  String toString() {
    return "CannotPowException: multiplier must be higher or equal 0";
  }
}
