import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

@LazySingleton()
class VoiceRecordingService {
  final StreamController<Amplitude> _amplitudeController = StreamController<Amplitude>.broadcast();
  final SpeechToText _speechToText = SpeechToText();

  Stream<Amplitude> get amplitudeStream => _amplitudeController.stream;

  Future<bool> initialize({required void Function(SpeechRecognitionError error)? onError}) async {
    return await _speechToText.initialize(onError: onError);
  }

  bool get isListening => _speechToText.isListening;

  Future<void> start({
    String? locale,
    required Function(String recognizedWords, bool isFinal) onResult,
  }) async {
    await _speechToText.listen(
      listenOptions: SpeechListenOptions(localeId: locale),
      onResult: (result) => onResult(result.recognizedWords, result.finalResult),
      onSoundLevelChange: (level) {
        if (_amplitudeController.isClosed) return;

        final normalized = (level.abs() * 2).clamp(5.0, 100.0);
        _amplitudeController.add(Amplitude(current: normalized, max: 100.0));
      },
    );
  }

  Future<void> stop() async {
    await _speechToText.stop();
  }

  Future<void> dispose() async {
    await _amplitudeController.close();
    await _speechToText.cancel();
  }
}
