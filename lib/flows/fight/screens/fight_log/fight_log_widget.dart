import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/screens/fight_log/log_item_widget.dart';
import 'package:flutter/widgets.dart';

class FightLogWidget extends StatelessWidget {
  final List<LogModel> logs;
  final Key testKey;

  const FightLogWidget({Key? key, required this.testKey, required this.logs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: testKey,
        initialItemCount: 0,
        reverse: true,
        itemBuilder: (context, position, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: LogItemWidget(logModel: logs[position]),
          );
        });
  }
}
