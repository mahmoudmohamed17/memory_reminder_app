import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/memory_model.dart';
import '../../../core/repositories/memory_repository.dart';
import '../../../core/utils/enums.dart';

part 'memories_list_state.dart';

@injectable
class MemoriesListCubit extends Cubit<MemoriesListState> {
  final MemoryRepository _repo;
  StreamSubscription<List<MemoryModel>>? _sub;

  MemoriesListCubit(this._repo) : super(const MemoriesListLoading());

  /// Starts watching memories, optionally filtered by [category].
  /// Safe to call multiple times — cancels any previous subscription first.
  void watch({MemoryCategory? category}) {
    _sub?.cancel();
    emit(const MemoriesListLoading());

    _sub = _repo
        .watchMemories(category: category)
        .listen(
          (list) => emit(MemoriesListLoaded(memories: list, activeCategory: category)),
          onError: (Object e) => emit(MemoriesListError(e.toString())),
        );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
