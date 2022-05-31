import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/personalty/data/personalties_service_impl.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_fight_progress.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testUtils/mocked_models.dart';

void main() {
  test("Personalties service returns provided list of personalties", () {
    final list = <Personalty>[Personalty("key", "Test", emptyLevel(), 3, AttributeTag.rock)];
    final underTest = PersonaltiesServiceImpl(list);
    expect(underTest.personalties, list);
  });

  test("Personalties service returns stream with provided list", () {
    final list = <Personalty>[Personalty("key", "Test", emptyLevel(), 3, AttributeTag.rock)];
    final underTest = PersonaltiesServiceImpl(list);
    underTest.listenToPersonalties().listen(expectAsync1((returned) {
      expect(returned, list);
    }, count: 1));
  });

  test("Personalties service accepts PersonaltyOffer and updates correct Personalty", () async {
    final list = <Personalty>[Personalty("key", "Test", emptyLevel(), 3, AttributeTag.rock)];
    final underTest = PersonaltiesServiceImpl(list);

    final offer = PersonaltyOffer(list.first.key, emptyCurrency());
    await underTest.buyPersonaltyLevel(offer);
    expect(underTest.personalties.first.level, 1);
  });

  test("Personalties service gets progress list after fight and updates experience", () async {
    final list = <Personalty>[
      Personalty("key", "Test", emptyLevel(), 3, AttributeTag.rock),
      Personalty("key1", "Test", emptyLevel(), 3, AttributeTag.rock),
    ];
    final underTest = PersonaltiesServiceImpl(list);

    final afterFightProgress = <PersonaltyFightProgress>[
      PersonaltyFightProgress(list.first.key, 21),
      PersonaltyFightProgress(list.last.key, 37),
    ];
    await underTest.addFightProgress(afterFightProgress);
    for (var progress in afterFightProgress) {
      final personalty = underTest.personalties.firstWhere((personalty) => personalty.key == progress.key);
      expect(personalty.experience, progress.experience);
    }
  });
}
