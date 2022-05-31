class InGameLevel {
  final int level;
  final int experience;
  final int experienceStrategy;

  InGameLevel({required this.level, required this.experience, required this.experienceStrategy});

  InGameLevel operator +(int experience) {
    final experienceSum = this.experience + experience;
    final newLevel = level + (experienceSum / experienceStrategy).floor();
    final newExperience = experienceSum % experienceStrategy;
    return InGameLevel(level: newLevel, experience: newExperience, experienceStrategy: experienceStrategy);
  }
}
