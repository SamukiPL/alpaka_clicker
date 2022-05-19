import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:flutter/material.dart';

class HealthWidget extends StatelessWidget {
  final HealthModel _healthModel;

  const HealthWidget(this._healthModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber), borderRadius: const BorderRadius.all(Radius.circular(16))),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          LinearProgressIndicator(
            value: _healthModel.healthPercentage,
            backgroundColor: Colors.grey,
            color: Colors.red,
          ),
          Text(
            _healthModel.displayableHealth,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
