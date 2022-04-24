import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSize MainScreenToolbar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: _MainScreenToolbar(),
  );
}

class _MainScreenToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      color: Colors.white,
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Papaj",
              style: defaultTextStyle(24),
            ),
          ],
        ),
      ),
    );
  }
}
