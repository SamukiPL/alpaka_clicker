import 'package:alpaka_clicker/screens/game/alpaka_clicker_widget.dart';
import 'package:alpaka_clicker/screens/splash/splash_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashScreenController _controller = SplashScreenController();

  @override
  Widget build(BuildContext context) {
    when((test) {
      return _controller.dependenciesLoaded;
    }, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AlpakaClickerWidget()));
    });
    _controller.loadDependencies();
    return Container();
  }

}