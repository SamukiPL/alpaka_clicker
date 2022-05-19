import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/turn_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogItemWidget extends StatelessWidget {
  final LogModel logModel;

  const LogItemWidget({Key? key, required this.logModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logWidth = MediaQuery.of(context).size.width * 0.8;
    return Container(
      color: _getBackground(logModel.logPerson),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Align(
        alignment: _getAlignment(logModel.logPerson),
        child: SizedBox(
          width: logWidth,
          child: Text(
            logModel.text,
            textAlign: _getAlignText(logModel.logPerson),
          ),
        ),
      ),
    );
  }

  Color _getBackground(TurnType person) => (person == TurnType.player) ? Colors.white : Colors.amber.shade50;

  Alignment _getAlignment(TurnType person) =>
      (person == TurnType.player) ? Alignment.centerLeft : Alignment.centerRight;

  TextAlign _getAlignText(TurnType person) => (person == TurnType.player) ? TextAlign.start : TextAlign.end;
}
