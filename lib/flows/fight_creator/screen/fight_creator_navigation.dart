import 'package:alpaka_clicker/flows/fight/screen/fight_screen.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class FightCreatorNavigation {
  void goToFightScreen(BuildContext context, DifficultyModel model) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FightScreen(difficultyModel: model)));
  }
}
