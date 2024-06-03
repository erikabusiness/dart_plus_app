import 'package:dart_plus_app/services/SpeechRecognitionService.dart';

class VoiceControl {
  final SpeechRecognitionService _speechRecognitionService =
      SpeechRecognitionService();

  VoiceControl() {
    _speechRecognitionService.init();
  }

  void startListening(
      Function(String) onResultCallback, Function(String) onErrorCallback) {
    _speechRecognitionService.onResultCallback = onResultCallback;
    _speechRecognitionService.onResultCallback = onErrorCallback;
    _speechRecognitionService.start();
  }

  void stopListening() {
    _speechRecognitionService.stop();
  }
}
