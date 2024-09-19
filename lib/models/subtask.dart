// lib/models/subtask.dart

class Subtask {
  String description;
  bool isCompleted;

  Subtask({
    required this.description,
    this.isCompleted = false,
  });
}
