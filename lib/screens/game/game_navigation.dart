import 'package:alpaka_clicker/screens/property_shop/property_shop_screen.dart';
import 'package:alpaka_clicker/util/widgets/navigation_bar/navigation_bar_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class GameNavigation implements NavigationBarListener {
  @override
  void clothingClicked(BuildContext context) {
    // TODO: implement clothingClicked
  }

  @override
  void settingsClicked(BuildContext context) {
    // TODO: implement settingsClicked
  }

  @override
  void shopClicked(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyShopScreen()));
  }

  @override
  void upgradesClicked(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => throw UnimplementedError()));
  }
}
