import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handler/error_handler.dart';
import '../../../../core/models/memory_model.dart';
import '../../../../core/repositories/memory_repository.dart';

part 'memory_details_state.dart';

@injectable
class MemoryDetailsCubit extends Cubit<MemoryDetailsState> {
  final MemoryRepository _repo;
  StreamSubscription<Result<MemoryModel?>>? _sub;

  MemoryDetailsCubit(this._repo) : super(const MemoryDetailsLoading());

  /// Starts watching a single memory by [id].
  /// Emits [MemoryDetailsDeleted] if the memory is removed from elsewhere.
  void watch(int id) {
    _sub?.cancel();
    emit(const MemoryDetailsLoading());

    _sub = _repo.watchMemory(id).listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (error) => emit(MemoryDetailsError(error.messageKey)),
          (model) {
            if (model == null) {
              emit(const MemoryDetailsDeleted());
            } else {
              emit(MemoryDetailsLoaded(memory: model));
            }
          },
        );
      },
    );
  }

  /// Permanently deletes the memory and all its attachments.
  Future<void> deleteMemory(int id) async {
    final result = await _repo.deleteMemory(id);
    result.fold(
      (error) => emit(MemoryDetailsError(error.messageKey)),
      (_) => emit(const MemoryDetailsDeleted()),
    );
  }

  /// Removes a single attachment from the memory.
  Future<void> removeAttachment(int attachmentId) async {
    final result = await _repo.removeAttachment(attachmentId);
    result.fold(
      (error) => emit(MemoryDetailsError(error.messageKey)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
