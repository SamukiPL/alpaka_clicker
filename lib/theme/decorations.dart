import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BorderRadius defaultRadius() => const BorderRadius.all(Radius.circular(8));

BoxDecoration defaultDecoration() => BoxDecoration(
  borderRadius: defaultRadius(),
  border: Border.all(color: const Color(0xFFD5A800)),
  color: Colors.white
);

Decoration buttonDecoration() => defaultDecoration().copyWith(
  color: Colors.transparent
);