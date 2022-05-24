import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/attribute_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class CharacterToCharacterInfoMapper {
  CharacterInfoModel call(Character character) => CharacterInfoModel(
        character.name,
        character.level,
        character.experience,
        character.experienceStrategy,
        character.pointsToDistribute,
        attributesToModels(character),
      );

  List<AttributeModel> attributesToModels(Character character) => [
    AttributeModel(AttributeTag.rock, character.rockLevel, character.rockGrade),
    AttributeModel(AttributeTag.paper, character.paperLevel, character.paperGrade),
    AttributeModel(AttributeTag.scissors, character.scissorsLevel, character.scissorsGrade),
    AttributeModel(AttributeTag.knowledge, character.knowledgeLevel, character.knowledgeGrade),
  ];
}
