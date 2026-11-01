import 'package:dartz/dartz.dart';

import '../../config/error_handler/error_handler.dart';
import '../models/memory_attachment_input.dart';
import '../models/memory_model.dart';
import '../utils/enums.dart';

abstract class MemoryRepository {
  Stream<Result<List<MemoryModel>>> watchMemories({
    MemoryCategory? category,
    String query = '',
  });

  Stream<Result<MemoryModel?>> watchMemory(int id);

  Future<Result<int>> addMemory({
    required String title,
    String description = '',
    required MemoryCategory category,
  });

  Future<Result<Unit>> updateMemory({
    required int id,
    required String title,
    required String description,
    required MemoryCategory category,
  });

  Future<Result<Unit>> updateMemoryWithAttachments({
    required int id,
    required String title,
    required String description,
    required MemoryCategory category,
    required List<MemoryAttachmentInput> additions,
    required List<int> removals,
  });

  Future<Result<Unit>> deleteMemory(int id);

  Future<Result<int>> addAttachment({
    required int memoryId,
    required MemoryAttachmentInput attachment,
  });

  Future<Result<List<int>>> addAttachments({
    required int memoryId,
    required List<MemoryAttachmentInput> attachments,
  });

  Future<Result<Unit>> removeAttachment(int attachmentId);
}
