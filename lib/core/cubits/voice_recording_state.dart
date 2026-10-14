part of 'voice_recording_cubit.dart';

sealed class VoiceRecordingState {
  const VoiceRecordingState();
}

final class VoiceRecordingInitial extends VoiceRecordingState {
  const VoiceRecordingInitial();
}

final class VoiceRecordingLoading extends VoiceRecordingState {
  const VoiceRecordingLoading();
}

final class VoiceRecordingListening extends VoiceRecordingState {
  final String words;

  const VoiceRecordingListening({required this.words});
}

final class VoiceRecordingSuccess extends VoiceRecordingState {
  final String words;

  const VoiceRecordingSuccess({required this.words});
}

final class VoiceRecordingError extends VoiceRecordingState {
  final String error;

  const VoiceRecordingError({required this.error});
}
