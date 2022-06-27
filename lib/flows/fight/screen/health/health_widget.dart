import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/util/widgets/rounded_progress_widget.dart';
import 'package:flutter/material.dart';

class HealthWidget extends StatelessWidget {
  final HealthModel _healthModel;

  const HealthWidget(this._healthModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: RoundedProgressWidget(
        value: _healthModel.healthPercentage,
        displayableValue: _healthModel.displayableHealth,
        backgroundColor: Colors.grey,
        color: Colors.red,
      ),
    );
  }
}
