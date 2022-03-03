import 'package:alpaka_clicker/util/widgets/money_counters/floating_money_counter.dart';
import 'package:alpaka_clicker/util/widgets/positioned_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreenMenu extends StatelessWidget {
  const MainScreenMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingMoneyCounter(
            top: 16,
            left: 16),
        PositionedButton(
            bottom: 16 + 32 + 16 + 16,
            left: 16,
            onTap: () {},
            child: Image.asset(
              "assets/images/gear.png",
              height: 32,
              width: 32,
            )),
        PositionedButton(
            bottom: 16,
            left: 16,
            onTap: () {},
            child: Row(
              children: [
                const Text(
                  "Walcz",
                  style: TextStyle(fontSize: 24, color: Color(0xFFD5A800)),
                ),
                Image.asset(
                  "assets/images/fight.png",
                  height: 32,
                  width: 32,
                )
              ],
            )),
        PositionedButton(
            bottom: 16,
            right: 16,
            onTap: () {},
            child: Image.asset(
              "assets/images/clothing.png",
              height: 32,
              width: 32,
            )),
        PositionedButton(
            bottom: 16,
            right: 16 + 32 + 16 + 16,
            onTap: () {},
            child: Image.asset(
              "assets/images/upgrades.png",
              height: 32,
              width: 32,
            )),
        PositionedButton(
            bottom: 16,
            right: 16 + 32 + 16 + 16 + 32 + 16 + 16,
            onTap: () {},
            child: Image.asset(
              "assets/images/shop.png",
              height: 32,
              width: 32,
            ))
      ],
    );
  }

}