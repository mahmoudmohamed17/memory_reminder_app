import '../models/memory_model.dart';
import '../utils/enums.dart';

abstract class MemoryRepository {
  Stream<List<MemoryModel>> watchMemories({
    MemoryCategory? category,
    String query = '',
  });

  Stream<MemoryModel?> watchMemory(int id);

  Future<int> addMemory({
    required String title,
    String description = '',
    required MemoryCategory category,
  });

  Future<void> updateMemory({
    required int id,
    required String title,
    required String description,
    required MemoryCategory category,
  });

  Future<void> deleteMemory(int id);

  Future<int> addAttachment({
    required int memoryId,
    required AttachmentType type,
    required String relativePath,
    int sizeBytes = 0,
  });

  Future<void> removeAttachment(int attachmentId);
}
