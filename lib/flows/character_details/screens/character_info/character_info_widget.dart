import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:alpaka_clicker/util/widgets/rounded_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CharacterInfoWidget extends StatelessWidget {
  final CharacterInfoModel infoModel;

  const CharacterInfoWidget({Key? key, required this.infoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                width: double.infinity,
                height: 150,
                decoration: defaultDecoration(),
                padding: const EdgeInsets.all(4),
                child: Image.asset("assets/images/papa_face.png"),
              )),
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Papajak Watykaniak",
                        style: defaultTextStyle(24),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        "Poziom 2137",
                        style: defaultTextStyle(16).copyWith(color: BaseColors.primary.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 8,),
                      RoundedProgressWidget(
                        height: 25,
                        value: 1 / 2,
                        displayableValue: "${1252~/2}/${infoModel.experienceToNextLevel}",
                        backgroundColor: BaseColors.primary.withOpacity(0.2),
                        color: BaseColors.primary,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
