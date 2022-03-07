import 'package:flutter/cupertino.dart';

abstract class NavigationBarListener {
  void shopClicked(BuildContext context);

  void upgradesClicked(BuildContext context);

  void clothingClicked(BuildContext context);

  void settingsClicked(BuildContext context);
}
