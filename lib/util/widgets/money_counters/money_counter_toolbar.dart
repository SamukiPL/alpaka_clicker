import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSize MoneyCounterToolbar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: _MoneyCounterToolbar(),
  );
}

class _MoneyCounterToolbar extends StatelessWidget {
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
            Center(
              child: MoneyCounter(
                textStyle: defaultTextStyle(24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
