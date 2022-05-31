import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: BaseColors.primary,
      ),
    );
  }

}
