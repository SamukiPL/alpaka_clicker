import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/dice_roller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../testUtils/mocks.mocks.dart';

void main() {
  final probability = Probability(100, {
    25: AttributeTag.rock,
    50: AttributeTag.paper,
    75: AttributeTag.scissors,
    100: AttributeTag.knowledge
  });
  setUpAll(() {
    resetMockitoState();
  });

  test("DiceRoller accepts probability and returns randomized attribute", () {
    final random = MockRandom();
    when(random.nextInt(any)).thenReturn(24);
    final underTest = DiceRoller(random);
    AttributeTag returned = underTest.rollForAttribute(probability);
    // ignore: unnecessary_type_check
    assert(returned is AttributeTag);
  });

  test("DiceRoller rolls rock when random returns int lower than rock key in map", () {
    final random = MockRandom();
    final underTest = DiceRoller(random);
    when(random.nextInt(any)).thenReturn(24);

    final returned = underTest.rollForAttribute(probability);
    expect(returned, AttributeTag.rock);
    verify(random.nextInt(probability.probSum)).called(1);
  });

  test("DiceRoller rolls rock when random returns int lower than rock key in map", () {
    final random = MockRandom();
    final underTest = DiceRoller(random);
    when(random.nextInt(any)).thenReturn(49);

    final returned = underTest.rollForAttribute(probability);
    expect(returned, AttributeTag.paper);
    verify(random.nextInt(probability.probSum)).called(1);
  });

  test("DiceRoller rolls rock when random returns int lower than rock key in map", () {
    final random = MockRandom();
    final underTest = DiceRoller(random);
    when(random.nextInt(any)).thenReturn(74);

    final returned = underTest.rollForAttribute(probability);
    expect(returned, AttributeTag.scissors);
    verify(random.nextInt(probability.probSum)).called(1);
  });

  test("DiceRoller rolls rock when random returns int lower than rock key in map", () {
    final random = MockRandom();
    final underTest = DiceRoller(random);
    when(random.nextInt(any)).thenReturn(99);

    final returned = underTest.rollForAttribute(probability);
    expect(returned, AttributeTag.knowledge);
    verify(random.nextInt(probability.probSum)).called(1);
  });
}
