import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../config/error_handler/error_handler.dart';
import '../models/memory_model.dart';
import '../utils/enums.dart';

class MemoryAttachmentInput {
  const MemoryAttachmentInput({
    required this.file,
    required this.name,
    required this.type,
    required this.sizeBytes,
  });

  final File file;
  final String name;
  final AttachmentType type;
  final int sizeBytes;
}

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

  Future<Result<Unit>> deleteMemory(int id);

  Future<Result<int>> addAttachment({
    required int memoryId,
    required AttachmentType type,
    required String relativePath,
    int sizeBytes = 0,
  });

  Future<Result<List<int>>> addAttachments({
    required int memoryId,
    required List<MemoryAttachmentInput> attachments,
  });

  Future<Result<Unit>> removeAttachment(int attachmentId);
}
