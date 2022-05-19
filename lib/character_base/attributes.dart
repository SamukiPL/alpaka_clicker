enum AttributeTag { rock, paper, scissors, knowledge }

enum Grade { s, a, b, c, d, e, f }

abstract class Attribute {
  final AttributeTag tag;
  final List<AttributeTag> strengths;
  final int level;
  final Grade grade;

  Attribute(this.tag, this.strengths, this.level, this.grade);

  Attribute operator +(int level);
}

class Rock extends Attribute {
  Rock(int level, Grade grade) : super(AttributeTag.rock, [AttributeTag.scissors], level, grade);

  @override
  Rock operator +(int level) {
    return Rock(this.level + level, grade);
  }
}

class Paper extends Attribute {
  Paper(int level, Grade grade) : super(AttributeTag.paper, [AttributeTag.rock], level, grade);

  @override
  Paper operator +(int level) {
    return Paper(this.level + level, grade);
  }
}

class Scissors extends Attribute {
  Scissors(int level, Grade grade) : super(AttributeTag.scissors, [AttributeTag.paper], level, grade);

  @override
  Scissors operator +(int level) {
    return Scissors(this.level + level, grade);
  }
}

class Knowledge extends Attribute {
  Knowledge(int level, Grade grade)
      : super(AttributeTag.knowledge, [AttributeTag.rock, AttributeTag.paper, AttributeTag.scissors], level, grade);

  @override
  Knowledge operator +(int level) {
    return Knowledge(this.level + level, grade);
  }
}
