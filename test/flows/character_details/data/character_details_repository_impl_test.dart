import 'package:alpaka_clicker/flows/character_details/data/character_details_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  final playerCharacter = emptyCharacter();

  final moneyService = MockMoneyService();
  final characterService = MockCharacterService();
  final personaltiesService = MockPersonaltiesService();
  final storeClerc = MockStoreClerc();
  final characterMapper = MockCharacterToCharacterInfoMapper();
  final personaltyModelMapper = MockToPersonaltyModelMapper();

  setUpAll(() {
    resetMockitoState();
    when(characterService.playerCharacter).thenReturn(playerCharacter);
  });

  test("Character repository returns character info", () async {
    final underTest = CharacterDetailsRepositoryImpl(moneyService, characterService, personaltiesService, storeClerc, characterMapper, personaltyModelMapper);
    final characterInfo = await underTest.getCharacterInfo();
    expect(characterInfo.name, playerCharacter.name);
    expect(characterInfo.currentLevel, playerCharacter.level);
    expect(characterInfo.currentExperience, playerCharacter.experience);
  });
}
