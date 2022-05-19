import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/screens/fight_log/log_item_widget.dart';
import 'package:flutter/widgets.dart';

class FightLogWidget extends StatelessWidget {
  final List<LogModel> logs;
  final GlobalKey<AnimatedListState> listKey;

  const FightLogWidget({Key? key, required this.listKey, required this.logs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: listKey,
        initialItemCount: 0,
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, position, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: LogItemWidget(logModel: logs[position]),
          );
        });
  }
}
