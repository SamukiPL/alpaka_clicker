import 'package:flutter_test/flutter_test.dart';

void expectThrow(Function testBlock, Type errorType) {
  bool didThrow = true;
  try {
    testBlock();
    didThrow = false;
  } catch(error) {
    expect(error.runtimeType, errorType);
  } finally {
    assert(didThrow);
  }
}