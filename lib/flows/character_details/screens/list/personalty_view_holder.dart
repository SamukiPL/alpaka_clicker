import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:alpaka_clicker/flows/character_details/screens/list/grade_evaluation_widget.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:alpaka_clicker/util/ext/attribute_ext.dart';
import 'package:alpaka_clicker/util/widgets/buttons/clicker_button.dart';
import 'package:flutter/material.dart';

class PersonaltyViewHolder extends StatelessWidget {
  final PersonaltyModel model;
  final Function onBuy;

  const PersonaltyViewHolder({Key? key, required this.model, required this.onBuy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.attributeTag.name(),
                style: defaultTextStyle(24),
              ),
              GradeEvaluationWidget(grade: model.attributeGrade)
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "Siła klasy S. Twój papież jest naturalnie bardzo silny!",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 16,),
          Container(
            padding: EdgeInsets.all(8),
            decoration: defaultDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Text(model.name, style: defaultTextStyle(18),),
                        const SizedBox(height: 8,),
                        const Text("Na tym poziomie siłki, Twój papież odrodzi się z poziomem siły od 1 do 100",
                          style: TextStyle(color: Colors.grey, fontSize: 14),),
                      ],
                    ),
                  ),
                ),
                _buildBuyButton()
              ],
            ),
          ),
        ],
      ),
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
