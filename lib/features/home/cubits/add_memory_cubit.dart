import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/repositories/memory_repository.dart';
import '../../../core/utils/enums.dart';

part 'add_memory_state.dart';

@injectable
class AddMemoryCubit extends Cubit<AddMemoryState> {
  final MemoryRepository _repo;

  AddMemoryCubit(this._repo) : super(const AddMemoryInitial());

  /// Inserts a new memory and emits [AddMemorySuccess] with the generated id.
  Future<void> addMemory({
    required String title,
    required String description,
    required MemoryCategory category,
  }) async {
    emit(const AddMemoryLoading());
    try {
      final id = await _repo.addMemory(
        title: title,
        description: description,
        category: category,
      );
      emit(AddMemorySuccess(newMemoryId: id));
    } catch (e) {
      emit(AddMemoryError(e.toString()));
    }
  }

  /// Attaches a file to an already-created memory.
  Future<void> addAttachment({
    required int memoryId,
    required AttachmentType type,
    required String relativePath,
    int sizeBytes = 0,
  }) async {
    try {
      await _repo.addAttachment(
        memoryId: memoryId,
        type: type,
        relativePath: relativePath,
        sizeBytes: sizeBytes,
      );
    } catch (e) {
      emit(AddMemoryError(e.toString()));
    }
  }

  /// Resets to [AddMemoryInitial] so the form can be reused in the same session.
  void reset() => emit(const AddMemoryInitial());
}
