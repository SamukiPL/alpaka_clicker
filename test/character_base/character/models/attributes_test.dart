import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:flutter_test/flutter_test.dart';

class TestAttribute extends Attribute {
  TestAttribute({
    AttributeTag tag = AttributeTag.knowledge,
    List<AttributeTag> strengths = AttributeTag.values,
    int level = 0,
    Grade grade = Grade.f,
  }) : super(tag, strengths, level, grade);

  @override
  Attribute operator +(int level) {
    return TestAttribute(level: this.level + level);
  }
}

void main() {
  test("We have enum with attributes tags", () {
    expect(AttributeTag.values.length, 4);
  });

  test("We have enum with grades", () {
    expect(Grade.values.length, 7);
  });

  test("Attribute returns tag passed in constructor", () {
    const tag = AttributeTag.knowledge;
    final attribute = TestAttribute(tag: tag);
    expect(attribute.tag, AttributeTag.knowledge);
  });

  test("Attribute returns strengths list(other attributeTags list) passed in constructor", () {
    final strengthsList = [AttributeTag.rock, AttributeTag.knowledge];
    final attribute = TestAttribute(strengths: strengthsList);
    expect(attribute.strengths, strengthsList);
  });

  test("Attribute returns level passed in constructor", () {
    const level = 5;
    final attribute = TestAttribute(level: level);
    expect(attribute.level, level);
  });

  test("Attribute returns grade passed in constructor", () {
    const grade = Grade.s;
    final attribute = TestAttribute(grade: grade);
    expect(attribute.grade, grade);
  });

  test("Attribute can have it's level upgraded", () {
    const startLevel = 1;
    Attribute attribute = TestAttribute(level: startLevel, grade: Grade.s);
    expect(attribute.level, startLevel);
    attribute += 1;
    expect(attribute.level, startLevel + 1);
  });

  test("Rock, Paper and Scissors are all child classes of Attribute", () {
    const level = 1;
    const grade = Grade.a;
    Attribute rock = Rock(level, grade);
    rock += 1;
    assert(rock is Rock);
    expect(rock.level, level + 1);
    expect(rock.tag, AttributeTag.rock);
    expect(rock.strengths.length, 1);
    expect(rock.strengths, [AttributeTag.scissors]);

    Attribute paper = Paper(level, grade);
    paper += 1;
    assert(paper is Paper);
    expect(paper.level, level + 1);
    expect(paper.tag, AttributeTag.paper);
    expect(paper.strengths.length, 1);
    expect(paper.strengths, [AttributeTag.rock]);

    Attribute scissors = Scissors(level, grade);
    scissors += 1;
    assert(scissors is Scissors);
    expect(scissors.level, level + 1);
    expect(scissors.tag, AttributeTag.scissors);
    expect(scissors.strengths.length, 1);
    expect(scissors.strengths, [AttributeTag.paper]);

    Attribute knowledge = Knowledge(level, grade);
    knowledge += 1;
    assert(knowledge is Knowledge);
    expect(knowledge.level, level + 1);
    expect(knowledge.tag, AttributeTag.knowledge);
    expect(knowledge.strengths.length, 3);
    expect(knowledge.strengths, [AttributeTag.rock, AttributeTag.paper, AttributeTag.scissors]);
  });
}
