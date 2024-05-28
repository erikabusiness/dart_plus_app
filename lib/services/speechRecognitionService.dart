import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechRecognitionService {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isInitialized = false;

  void init() async {
    _speech = stt.SpeechToText();
    _isInitialized = await _speech.initialize(
      onStatus: (status) {
        if (kDebugMode) {
          print('onStatus: $status');
        }
        if (status == 'done' || status == 'notListening') {
          _isListening = false;
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('onError: ${error.errorMsg}');
        }
        _isListening = false;
        if (error.permanent) {
          // Handle permanent errors appropriately
        } else {
          // Try to restart listening if the error is not permanent
          start();
        }
      },
    );
  }

  void Function(String command)? onCommand;
  void Function(String text)? onResultCallback;

  bool get isListening => _isListening;

  void start() async {
    if (_isInitialized && !_isListening) {
      _isListening = true;
      _speech.listen(
        onResult: (result) {
          String text = result.recognizedWords;
          if (kDebugMode) {
            print(text);
          }
          if (onResultCallback != null) {
            onResultCallback!(text);
          }
          if (text.contains("abrir configurações")) {
            onCommand?.call("abrirConfiguracoes");
          } else if (text.contains("voltar")) {
            onCommand?.call("voltar");
          }
        },
        listenFor: const Duration(seconds: 30),
      );
    } else {
      print('Speech recognition is not initialized or already listening.');
    }
  }

  void stop() {
    if (_isListening) {
      _isListening = false;
      _speech.stop();
    }
  }
}
