import 'package:dart_plus_app/services/SpeechRecognitionService.dart';

class VoiceControl {
  final SpeechRecognitionService _speechRecognitionService =
      SpeechRecognitionService();

  VoiceControl() {
    _speechRecognitionService.init();
  }

  void startListening(Function(String) onResultCallback) {
    _speechRecognitionService.onResultCallback = onResultCallback;
    _speechRecognitionService.start();
  }

  void stopListening() {
    _speechRecognitionService.stop();
  }
}
