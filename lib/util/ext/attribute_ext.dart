import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension AttributeTagExt on AttributeTag {
  String name() {
    switch (this) {
      case AttributeTag.rock:
        return "Siła";
      case AttributeTag.paper:
        return "Charyzma";
      case AttributeTag.scissors:
        return "Zręczność";
      case AttributeTag.knowledge:
        return "Wiedza";
    }
  }

  String imagePath() {
    switch (this) {
      case AttributeTag.rock:
        return "assets/images/rock.png";
      case AttributeTag.paper:
        return "assets/images/paper.png";
      case AttributeTag.scissors:
        return "assets/images/scissors.png";
      case AttributeTag.knowledge:
        return "assets/images/knowledge.png";
    }
  }
}

extension GradeExt on Grade {
  String gradeText() {
    switch (this) {
      case Grade.s:
        return "S";
      case Grade.a:
        return "A";
      case Grade.b:
        return "B";
      case Grade.c:
        return "C";
      case Grade.d:
        return "D";
      case Grade.e:
        return "E";
      case Grade.f:
        return "F";
    }
  }

  Color gradeColor() {
    switch (this) {
      case Grade.s:
        return BaseColors.primary;
      case Grade.a:
        return Colors.green;
      case Grade.b:
        return Colors.greenAccent;
      case Grade.c:
        return Colors.cyan;
      case Grade.d:
        return Colors.blue;
      case Grade.e:
        return Colors.indigo;
      case Grade.f:
        return Colors.red;
    }
  }
}
