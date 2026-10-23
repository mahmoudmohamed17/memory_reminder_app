import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/memory_model.dart';
import '../../../core/repositories/memory_repository.dart';

part 'memory_details_state.dart';

@injectable
class MemoryDetailsCubit extends Cubit<MemoryDetailsState> {
  final MemoryRepository _repo;
  StreamSubscription<MemoryModel?>? _sub;

  MemoryDetailsCubit(this._repo) : super(const MemoryDetailsLoading());

  /// Starts watching a single memory by [id].
  /// Emits [MemoryDetailsDeleted] if the memory is removed from elsewhere.
  void watch(int id) {
    _sub?.cancel();
    emit(const MemoryDetailsLoading());

    _sub = _repo.watchMemory(id).listen(
      (model) {
        if (isClosed) return;
        if (model == null) {
          emit(const MemoryDetailsDeleted());
        } else {
          emit(MemoryDetailsLoaded(memory: model));
        }
      },
      onError: (Object e) => emit(MemoryDetailsError(e.toString())),
    );
  }

  /// Permanently deletes the memory and all its attachments.
  Future<void> deleteMemory(int id) async {
    try {
      await _repo.deleteMemory(id);
      emit(const MemoryDetailsDeleted());
    } catch (e) {
      emit(MemoryDetailsError(e.toString()));
    }
  }

  /// Removes a single attachment from the memory.
  Future<void> removeAttachment(int attachmentId) async {
    try {
      await _repo.removeAttachment(attachmentId);
    } catch (e) {
      emit(MemoryDetailsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
