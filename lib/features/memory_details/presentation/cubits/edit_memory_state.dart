part of 'edit_memory_cubit.dart';

sealed class EditMemoryState {
  const EditMemoryState();
}

final class EditMemoryInitial extends EditMemoryState {
  const EditMemoryInitial();
}

final class EditMemoryLoading extends EditMemoryState {
  const EditMemoryLoading();
}

/// Emitted when [MemoryRepository.updateMemory] completes successfully.
/// The UI should respond by popping the edit screen so [MemoryDetailsCubit]'s
/// stream automatically delivers the refreshed model.
final class EditMemorySuccess extends EditMemoryState {
  const EditMemorySuccess();
}

final class EditMemoryError extends EditMemoryState {
  final String message;

  const EditMemoryError(this.message);
}
