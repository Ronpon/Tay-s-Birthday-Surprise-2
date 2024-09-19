// lib/models/speech_check.dart

class SpeechCheck {
  String prompt;
  int successThreshold;
  String successResult;
  String failureResult;

  SpeechCheck({
    required this.prompt,
    required this.successThreshold,
    required this.successResult,
    required this.failureResult,
  });
}
