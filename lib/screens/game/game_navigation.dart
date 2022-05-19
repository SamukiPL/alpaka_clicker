import 'package:alpaka_clicker/flows/fight/screens/fight_screen.dart';
import 'package:alpaka_clicker/flows/property_shop/screens/property_shop_screen.dart';
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => FightScreen()));
  }

  void goToPropertyShop(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyShopScreen()));
  }

  void goToUpgrades(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => throw UnimplementedError()));
  }
}
