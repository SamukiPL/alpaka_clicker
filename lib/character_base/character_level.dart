class CharacterLevel {
  final int level;
  final int experience;
  final int experienceStrategy;

  CharacterLevel({required this.level, required this.experience, required this.experienceStrategy});

  CharacterLevel operator +(int experience) {
    final experienceSum = this.experience + experience;
    final newLevel = level + (experienceSum / experienceStrategy).floor();
    final newExperience = experienceSum % experienceStrategy;
    return CharacterLevel(level: newLevel, experience: newExperience, experienceStrategy: experienceStrategy);
  }
}
