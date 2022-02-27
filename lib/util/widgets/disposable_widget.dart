import 'package:flutter/cupertino.dart';

class DisposableWidget extends StatefulWidget {
  final Widget child;
  final void Function() dispose;

  const DisposableWidget({Key? key, required this.dispose, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DisposableState();
}

class _DisposableState extends State<DisposableWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}