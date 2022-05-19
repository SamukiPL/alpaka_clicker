import 'dart:math';

import 'package:injectable/injectable.dart';

@module
abstract class MainModule {
  Random get random => Random();

  @Named("fullHealth")
  int get fullHealth => 60 * 21 + 37;
}
