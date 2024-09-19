// lib/models/perk.dart

class Perk {
  String name;
  String description;
  int requiredLevel;
  int maxLevel;
  int currentLevel;

  Perk({
    required this.name,
    required this.description,
    required this.requiredLevel,
    required this.maxLevel,
    this.currentLevel = 0,
  });
}
