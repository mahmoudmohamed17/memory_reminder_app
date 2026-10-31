import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/repositories/memory_repository.dart';
import '../../../core/utils/enums.dart';

part 'edit_memory_state.dart';

@injectable
class EditMemoryCubit extends Cubit<EditMemoryState> {
  final MemoryRepository _repo;

  EditMemoryCubit(this._repo) : super(const EditMemoryInitial());

  /// Persists the updated memory fields to the database.
  Future<void> updateMemory({
    required int id,
    required String title,
    required String description,
    required MemoryCategory category,
  }) async {
    emit(const EditMemoryLoading());
    try {
      await _repo.updateMemory(
        id: id,
        title: title,
        description: description,
        category: category,
      );
      emit(const EditMemorySuccess());
    } catch (e) {
      emit(EditMemoryError(e.toString()));
    }
  }

  /// Resets to initial so the screen can handle re-editing without restart.
  void reset() => emit(const EditMemoryInitial());
}
