import 'package:alpaka_clicker/flows/fight/screens/flame/enemy.dart';
import 'package:alpaka_clicker/flows/fight/screens/flame/fighter.dart';
import 'package:flame/game.dart';

class FightGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(Fighter());
    add(Enemy());
    super.onLoad();
  }
}
