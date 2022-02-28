import 'package:alpaka_clicker/util/widgets/navigation_bar/navigation_bar_listener.dart';
import 'package:alpaka_clicker/util/widgets/navigation_bar/navigation_bar_paint.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final NavigationBarListener listener;

  const NavigationBarWidget({Key? key, required this.listener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(children: [
      CustomPaint(
        size: Size(size.width, 80),
        painter: NavigationBarPaint(),
      ),
      SizedBox(
        width: size.width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildImage("assets/images/shop.png", () => listener.shopClicked(context)),
            getDivider(),
            buildImage("assets/images/upgrades.png", () => listener.upgradesClicked(context)),
            getDivider(),
            buildImage("assets/images/clothing.png", () => listener.clothingClicked(context)),
            getDivider(),
            buildImage("assets/images/gear.png", () => listener.settingsClicked(context)),
          ],
        ),
      )
    ]);
  }

  Widget buildImage(String path, Function navigationEvent) => GestureDetector(
    onTap: () => navigationEvent(),
    child: Image.asset(path,
        height: 60, width: 60, fit: BoxFit.fill, color: const Color(0xff4d3513)),
  );

  Widget getDivider() => const VerticalDivider(
        color: Color(0x60171717),
        thickness: 0.8,
        indent: 20,
        endIndent: 20,
      );
}
