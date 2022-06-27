import 'package:alpaka_clicker/flows/fight/screen/flame/enemy.dart';
import 'package:alpaka_clicker/flows/fight/screen/flame/fighter.dart';
import 'package:flame/game.dart';

class FightGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(Fighter());
    add(Enemy());
    super.onLoad();
  }
}
