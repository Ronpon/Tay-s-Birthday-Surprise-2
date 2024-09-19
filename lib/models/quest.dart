// lib/models/quest.dart

import 'speech_check.dart';
import 'subtask.dart';

class Quest {
  String title;
  String description;
  late final String originalDescription; // To reset after speech checks
  int experience;
  int caps;
  bool isRepeatable;
  bool isCompleted;
  bool canWager;
  List<SpeechCheck> speechChecks;
  List<Subtask> subtasks;
  List<String> speechCheckResults; // Tracks attempted speech checks

  Quest({
    required this.title,
    required this.description,
    required this.experience,
    required this.caps,
    required this.isRepeatable,
    this.isCompleted = false,
    this.canWager = false,
    required this.speechChecks,
    List<Subtask>? subtasks,
    List<String>? speechCheckResults,
  })  : subtasks = subtasks ?? [],
        speechCheckResults = speechCheckResults ?? [] {
    originalDescription = description;
  }
}
