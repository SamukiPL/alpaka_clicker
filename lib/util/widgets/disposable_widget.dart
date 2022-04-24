import 'package:flutter/cupertino.dart';

class DisposableWidget extends StatefulWidget {
  final Widget child;
  final void Function()? initialize;
  final void Function() dispose;

  const DisposableWidget({Key? key, this.initialize, required this.dispose, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DisposableState();
}

class _DisposableState extends State<DisposableWidget> {

  @override
  void initState() {
    widget.initialize?.call();
    super.initState();
  }

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
