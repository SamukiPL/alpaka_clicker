import 'package:alpaka_clicker/flows/character_details/screen/character_details_screen.dart';
import 'package:alpaka_clicker/flows/fight_creator/screen/fight_creator_screen.dart';
import 'package:alpaka_clicker/flows/property_shop/screen/property_shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class GameNavigation {
  void goToClothing(BuildContext context) {
    // TODO: implement clothingClicked
  }

  void goToSettings(BuildContext context) {
    // TODO: implement settingsClicked
  }

  void goToFight(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FightCreatorScreen()));
  }

  void goToPropertyShop(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyShopScreen()));
  }

  void goToCharacterDetails(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CharacterDetailsScreen()));
  }
}
