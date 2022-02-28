import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';

class MoneySymbol extends SpriteComponent with HasGameRef<ClickerGame> {
  @override
  Future<void>? onLoad() async{
    sprite = Sprite(await gameRef.images.load("putin.png"));
    height = 25;
    width = 25;
    x = 125;
    y = 25;
    anchor = Anchor.center;
    return super.onLoad();
  }
}