import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

import '../services/voice_recording_service.dart';

part 'voice_recording_state.dart';

@injectable
class VoiceRecordingCubit extends Cubit<VoiceRecordingState> {
  final VoiceRecordingService _service;

  VoiceRecordingCubit(this._service) : super(const VoiceRecordingInitial());

  Stream<Amplitude> get amplitudeStream => _service.amplitudeStream;

  bool get isRecording => _service.isListening;

  Future<void> startRecording() async {
    emit(const VoiceRecordingLoading());

    final isAvailable = await _service.initialize(
      onError: (error) {
        log('Voice recording is not available: ${error.toJson()}');
        emit(const VoiceRecordingError(error: 'Voice recording is not available'));
      },
    );

    if (!isAvailable) {
      log('Voice recording is not available');
      emit(const VoiceRecordingError(error: 'Voice recording is not available'));
      return;
    }

    emit(const VoiceRecordingListening(words: ''));

    await _service.start(
      onResult: (words, isFinal) {
        if (isFinal) {
          log('Success: $words');
          emit(VoiceRecordingSuccess(words: words));
        } else {
          log('Listening: $words');
          emit(VoiceRecordingListening(words: words));
        }
      },
    );
  }

  Future<void> stop() async {
    await _service.stop();
  }

  Future<void> toggle() async {
    if (_service.isListening) {
      await stop();
    } else {
      await startRecording();
    }
  }

  @override
  Future<void> close() async {
    await _service.dispose();
    return super.close();
  }
}
