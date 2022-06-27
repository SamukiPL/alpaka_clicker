import 'dart:math';

import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';

@module
abstract class MainModule {
  Random get random => Random();

  @Named("fullHealth")
  int get fullHealth => 60 * 21 + 37;

  @Named("levelRange")
  Range get levelRange => Range(1, 3);
}
