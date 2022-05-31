import 'package:alpaka_clicker/flows/character_details/domain/models/attribute_model.dart';

class CharacterInfoModel {
  final String name;
  final int currentLevel;
  final int currentExperience;
  final int experienceToNextLevel;
  final bool canDistributePoints;
  final int pointsToDistribute;
  final List<AttributeModel> attributes;

  CharacterInfoModel(this.name, this.currentLevel, this.currentExperience, this.experienceToNextLevel,
      this.canDistributePoints, this.pointsToDistribute, this.attributes);
}
