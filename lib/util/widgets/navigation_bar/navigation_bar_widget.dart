import 'package:alpaka_clicker/util/widgets/navigation_bar/navigation_bar_paint.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {

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
            buildImage("assets/images/shop.png", () {}),
            getDivider(),
            buildImage("assets/images/upgrades.png", () {}),
            getDivider(),
            buildImage("assets/images/clothing.png", () {}),
            getDivider(),
            buildImage("assets/images/gear.png", () {}),
          ],
        ),
      )
    ]);
  }

  Widget buildImage(String path, Function navigationEvent) => GestureDetector(
        onTap: () => navigationEvent(),
        child: Image.asset(path, height: 40, width: 40, fit: BoxFit.fill, color: const Color(0xFFD5A800)),
      );

  Widget getDivider() => const VerticalDivider(
        color: Color(0xFFD5A800),
        thickness: 0.8,
        indent: 20,
        endIndent: 20,
      );
}
