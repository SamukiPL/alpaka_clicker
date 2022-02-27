import 'package:alpaka_clicker/components/money_counter.dart';
import 'package:alpaka_clicker/components/money_particle.dart';
import 'package:alpaka_clicker/components/player.dart';
import 'package:alpaka_clicker/money/bank.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:get_it/get_it.dart';

class ClickerGame extends FlameGame with TapDetector, PanDetector {
  final _getIt = GetIt.instance;
  late final Bank bank;

  ClickerGame();

  @override
  Future<void> onLoad() async {
    bank = _getIt.get<Bank>();
    add(Player());
    add(MoneyCounter());
    super.onLoad();
  }

  @override
  void update(double dt) {
    bank.payInterest();
    super.update(dt);
  }

  @override
  void onTapUp(TapUpInfo info) {
    bank.paySalary();
    add(MoneyParticle(info.eventPosition.game, bank));
  }
}
