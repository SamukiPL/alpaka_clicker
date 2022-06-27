import 'package:alpaka_clicker/flows/character_details/domain/models/attribute_model.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:alpaka_clicker/util/ext/attribute_ext.dart';
import 'package:alpaka_clicker/util/widgets/alternating_widget/alternating_widget.dart';
import 'package:flutter/material.dart';

class QuickAttributesWidget extends StatelessWidget {
  final bool canDistributePoints;
  final List<AttributeModel> attributes;
  final Function(AttributeModel) distributePoint;

  const QuickAttributesWidget({Key? key, required this.canDistributePoints, required this.attributes, required this.distributePoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: attributes.map((attribute) => attributeColumn(attribute)).toList(),
    );
  }

  Widget attributeColumn(AttributeModel attribute) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: defaultRadius(),
            color: attribute.grade.gradeColor(),
          ),
          padding: const EdgeInsets.all(8),
          child: AlternatingWidget(
            firstWidget: FittedBox(
              child: Text(
                attribute.grade.gradeText(),
                style: const TextStyle(color: Colors.white, fontSize: 400, fontWeight: FontWeight.bold),
              ),
              fit: BoxFit.fill,
            ),
            secondWidget: Image.asset(attribute.tag.imagePath()),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          attribute.level.toString(),
          style: defaultTextStyle(18).copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        (canDistributePoints) ? Material(
          color: Colors.green,
          borderRadius: defaultRadius(),
          child: InkWell(
            onTap: () => distributePoint(attribute),
            customBorder: RoundedRectangleBorder(borderRadius: defaultRadius()),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 48,
            ),
          ),
        ) : Container(),
      ],
    );
  }
}
