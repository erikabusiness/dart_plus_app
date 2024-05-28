import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceCommandService {
  final SpeechToText _speech = SpeechToText();
  bool _hasSpeech = false;
  bool _isListening = false;
  String _lastWords = '';
  String _lastError = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  Function(String)? _onResult;
  Function(String)? _onStatusChange;

  Future<void> initialize() async {
    try {
      _hasSpeech = await _speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
      );
      if (_hasSpeech) {
        _localeNames = await _speech.locales();

        var systemLocale = await _speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
    } catch (e) {
      _lastError = 'Falha no reconhecimento de fala: ${e.toString()}';
      _hasSpeech = false;
    }
  }

  void startListening(
      Function(String) onResult, Function(String) onStatusChange,
      {int listenFor = 60, int pauseFor = 30}) {
    _onResult = onResult;
    _onStatusChange = onStatusChange;
    if (_hasSpeech && !_speech.isListening) {
      _speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: listenFor),
        pauseFor: Duration(seconds: pauseFor),
        localeId: _currentLocaleId,
        listenMode: ListenMode.confirmation,
        listenOptions: SpeechListenOptions(
          partialResults: true,
        ),
      );
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  void cancelListening() {
    if (_speech.isListening) {
      _speech.cancel();
    }
  }

  void resultListener(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords.toLowerCase();
    if (_onResult != null) {
      _onResult!(_lastWords);
    }
  }

  void errorListener(SpeechRecognitionError error) {
    _lastError = '${error.errorMsg} - ${error.permanent}';
  }

  void statusListener(String status) {
    _isListening = _speech.isListening;
    if (_onStatusChange != null) {
      _onStatusChange!(status);
    }
  }

  bool get hasSpeech => _hasSpeech;
  bool get isListening => _isListening;
  String get lastWords => _lastWords;
  String get lastError => _lastError;
  String get currentLocaleId => _currentLocaleId;
  List<LocaleName> get localeNames => _localeNames;
}
