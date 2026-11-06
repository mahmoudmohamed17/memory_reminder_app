import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

import '../services/voice_recording_service.dart';
import '../utils/app_strings.dart';

part 'voice_recording_state.dart';

@injectable
class VoiceRecordingCubit extends Cubit<VoiceRecordingState> {
  final VoiceRecordingService _service;

  VoiceRecordingCubit(this._service) : super(const VoiceRecordingInitial());

  Stream<Amplitude> get amplitudeStream => _service.amplitudeStream;

  bool get isRecording => _service.isListening;

  Future<void> startRecording() async {
    try {
      emit(const VoiceRecordingLoading());

      final isAvailable = await _service.initialize(
        onError: (error) {
          log('Voice initialization error: ${error.toJson()}');
          if (!isClosed) {
            emit(const VoiceRecordingError(error: AppStrings.voiceServiceNotAvailable));
          }
        },
      );

      if (!isAvailable) {
        if (!isClosed) {
          emit(const VoiceRecordingError(error: AppStrings.voiceServiceNotAvailable));
        }
        return;
      }

      if (isClosed) return;
      emit(const VoiceRecordingListening(words: ''));

      await _service.start(
        onResult: (words, isFinal) {
          if (isClosed) return;
          if (isFinal) {
            log('Success: $words');
            emit(VoiceRecordingSuccess(words: words));
          } else {
            log('Listening: $words');
            emit(VoiceRecordingListening(words: words));
          }
        },
      );
    } catch (e, stack) {
      log('Voice startRecording error: $e\n$stack');
      if (!isClosed) {
        emit(const VoiceRecordingError(error: AppStrings.voiceServiceNotAvailable));
      }
    }
  }

  Future<void> stop() async {
    try {
      await _service.stop();
    } catch (e) {
      log('Voice stop error: $e');
    }
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
    await _service.cancel();
    return super.close();
  }
}
