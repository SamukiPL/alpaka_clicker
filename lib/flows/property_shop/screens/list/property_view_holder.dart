import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:alpaka_clicker/util/widgets/buttons/clicker_button.dart';
import 'package:flutter/cupertino.dart';

class PropertyViewHolder extends StatelessWidget {
  final PropertyModel model;
  final Function onBuy;

  const PropertyViewHolder({Key? key, required this.model, required this.onBuy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildName(),
              Text(
                "Lvl ${model.count}",
                style: defaultTextStyle(16),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPerSecond(),
              _buildBuyButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/images/shop.png",
          height: 32,
          width: 32,
        ),
        Text(
          model.name,
          style: defaultTextStyle(18),
        )
      ],
    );
  }

  Widget _buildPerSecond() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/receive_money.png",
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          model.displayableIncome,
          style: defaultTextStyle(14),
        )
      ],
    );
  }

  Widget _buildBuyButton() {
    return ClickerButton(
      child: Row(
        children: [
          Text(
            model.displayablePrice,
            style: defaultTextStyle(14),
          ),
          Image.asset(
            "assets/images/pay_money.png",
            height: 24,
            width: 24,
          )
        ],
      ),
      onTap: onBuy,
    );
  }
}
