import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

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
  Future<int> addAttachment({
    required int memoryId,
    required AttachmentType type,
    required String relativePath,
    int sizeBytes = 0,
  }) {
    return _dao.insertAttachment(
      AttachmentsCompanion.insert(
        memoryId: memoryId,
        type: type,
        relativePath: relativePath,
        sizeBytes: Value(sizeBytes),
      ),
    );
  }

  @override
  Future<int> addMemory({
    required String title,
    String description = '',
    required MemoryCategory category,
  }) {
    return _dao.insertMemory(
      MemoriesCompanion.insert(
        title: title.trim(),
        description: Value(description.trim()),
        normalizedText: Value(_searchText(title, description)),
        category: category,
      ),
    );
  }

  @override
  Future<void> deleteMemory(int id) async {
    final paths = await _dao.deleteMemorry(id);
    await _fileService.deleteAll(paths);
  }

  @override
  Future<void> removeAttachment(int attachmentId) async {
    final path = await _dao.deleteAttachment(attachmentId);
    if (path != null) await _fileService.delete(path);
  }

  @override
  Future<void> updateMemory({
    required int id,
    required String title,
    required String description,
    required MemoryCategory category,
  }) {
    return _dao.updateMemory(
      id,
      MemoriesCompanion(
        title: Value(title.trim()),
        description: Value(description.trim()),
        normalizedText: Value(_searchText(title, description)),
        category: Value(category),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Stream<List<MemoryModel>> watchMemories({MemoryCategory? category, String query = ''}) {
    return _dao
        .watchAll(
          category: category,
          normalizedQuery: ArabicNormalizer.normalize(query),
        )
        .map((list) => list.map(_toModel).toList());
  }

  @override
  Stream<MemoryModel?> watchMemory(int id) => _dao.watchOne(id).map((d) => d == null ? null : _toModel(d));

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
