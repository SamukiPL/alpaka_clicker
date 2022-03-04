class CannotSubtractException implements Exception {}
class CannotMultiplyException implements Exception {
  @override
  String toString() {
    return "CannotMultiplyException: multiplier must be higher or equal 1";
  }
}
