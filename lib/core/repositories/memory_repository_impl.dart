import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../config/error_handler/error_handler.dart';
import '../database/app_database.dart';
import '../database/daos/memories_dao.dart';
import '../models/memory_model.dart';
import '../services/attachment_file_service.dart';
import '../utils/arabic_normalizer.dart';
import '../utils/enums.dart';
import 'memory_repository.dart';

@LazySingleton(as: MemoryRepository)
class MemoryRepositoryImpl implements MemoryRepository {
  final MemoriesDao _dao;
  final AttachmentFileService _fileService;

  new(this._dao, this._fileService);

  @override
  Future<Result<int>> addAttachment({
    required int memoryId,
    required AttachmentType type,
    required String relativePath,
    int sizeBytes = 0,
  }) => _attempt(
    () => _dao.insertAttachment(
      AttachmentsCompanion.insert(
        memoryId: memoryId,
        type: type,
        relativePath: relativePath,
        sizeBytes: Value(sizeBytes),
      ),
    ),
    (error) => AppError.memoryAttachmentFailed(cause: error),
  );

  @override
  Future<Result<int>> addMemory({
    required String title,
    String description = '',
    required MemoryCategory category,
  }) => _attempt(
    () => _dao.insertMemory(
      MemoriesCompanion.insert(
        title: title.trim(),
        description: Value(description.trim()),
        normalizedText: Value(_searchText(title, description)),
        category: category,
      ),
    ),
    (error) => AppError.memorySaveFailed(cause: error),
  );

  @override
  Future<Result<Unit>> deleteMemory(int id) => _attempt(() async {
    final paths = await _dao.deleteMemorry(id);
    await _fileService.deleteAll(paths);
    return unit;
  }, (error) => AppError.memoryDeleteFailed(cause: error));

  @override
  Future<Result<Unit>> removeAttachment(int attachmentId) => _attempt(() async {
    final path = await _dao.deleteAttachment(attachmentId);
    if (path != null) await _fileService.delete(path);
    return unit;
  }, (error) => AppError.memoryAttachmentFailed(cause: error));

  @override
  Future<Result<Unit>> updateMemory({
    required int id,
    required String title,
    required String description,
    required MemoryCategory category,
  }) => _attempt(
    () async {
      await _dao.updateMemory(
        id,
        MemoriesCompanion(
          title: Value(title.trim()),
          description: Value(description.trim()),
          normalizedText: Value(_searchText(title, description)),
          category: Value(category),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return unit;
    },
    (error) => AppError.memoryUpdateFailed(cause: error),
  );

  @override
  Stream<Result<List<MemoryModel>>> watchMemories({MemoryCategory? category, String query = ''}) {
    return _watch(
      _dao
          .watchAll(
            category: category,
            normalizedQuery: ArabicNormalizer.normalize(query),
          )
          .map((list) => list.map(_toModel).toList()),
      (error) => AppError.storageReadFailed(cause: error),
    );
  }

  @override
  Stream<Result<MemoryModel?>> watchMemory(int id) => _watch(
    _dao.watchOne(id).map((d) => d == null ? null : _toModel(d)),
    (error) => AppError.storageReadFailed(cause: error),
  );

  Future<Result<T>> _attempt<T>(Future<T> Function() action, AppError Function(Object) fallback) async {
    try {
      return Right(await action());
    } catch (error) {
      return Left(ErrorHandler.normalize(error, fallback: fallback));
    }
  }

  Stream<Result<T>> _watch<T>(Stream<T> stream, AppError Function(Object) fallback) => stream.transform(
    StreamTransformer<T, Result<T>>.fromHandlers(
      handleData: (value, sink) => sink.add(Right(value)),
      handleError: (error, _, sink) {
        final normalized = ErrorHandler.normalize(error, fallback: fallback);
        sink.add(Left(normalized));
      },
    ),
  );

  // Helpers
  String _searchText(String title, String body) => ArabicNormalizer.normalize('$title $body');

  MemoryModel _toModel(MemoryWithDetails d) {
    final model = d.memory;
    return MemoryModel(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      creationDate: model.createdAt,
      lastUpdateDate: model.updatedAt,
    );
  }
}
