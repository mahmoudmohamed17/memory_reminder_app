import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/repositories/memory_repository.dart';
import '../../../core/utils/enums.dart';

part 'add_memory_state.dart';

@injectable
class AddMemoryCubit extends Cubit<AddMemoryState> {
  final MemoryRepository _repo;
  final List<MemoryAttachmentInput> _selectedAttachments = [];

  AddMemoryCubit(this._repo) : super(const AddMemoryInitial());

  int get selectedAttachmentCount => _selectedAttachments.length;

  Future<void> pickAttachments() async {
    final List<PlatformFile> files = await FilePicker.pickFiles();

    if (files.isEmpty) return;

    for (final file in files) {
      final path = file.path;
      if (path == null) continue;
      final type = _attachmentType(file.extension);
      if (type == null) continue;
      if (_selectedAttachments.any((item) => item.file.path == path)) continue;
      final size = await file.length();
      _selectedAttachments.add(
        MemoryAttachmentInput(file: File(path), name: file.name, type: type, sizeBytes: size ?? 0),
      );
    }
    emit(AddMemoryAttachmentsUpdated(_selectedAttachments));
  }

  Future<void> removeAttachment(MemoryAttachmentInput input) async {
    _selectedAttachments.removeWhere((item) => item == input);
    emit(AddMemoryAttachmentsUpdated(_selectedAttachments));
  }

  /// Inserts a new memory and emits [AddMemorySuccess] with the generated id.
  Future<void> addMemory({
    required String title,
    required String description,
    required MemoryCategory category,
  }) async {
    emit(const AddMemoryLoading());
    final result = await _repo.addMemory(
      title: title,
      description: description,
      category: category,
    );
    await result.fold(
      (error) async => emit(AddMemoryError(error.messageKey)),
      (id) async {
        if (_selectedAttachments.isNotEmpty) {
          final attachmentsResult = await _repo.addAttachments(
            memoryId: id,
            attachments: List.unmodifiable(_selectedAttachments),
          );
          final hasError = attachmentsResult.fold((_) => true, (_) => false);
          if (hasError) {
            attachmentsResult.fold(
              (error) => emit(AddMemoryError(error.messageKey)),
              (_) {},
            );
            return;
          }
        }
        _selectedAttachments.clear();
        emit(AddMemorySuccess(newMemoryId: id));
      },
    );
  }

  /// Attaches a file to an already-created memory.
  Future<void> addAttachment({
    required int memoryId,
    required AttachmentType type,
    required String relativePath,
    int sizeBytes = 0,
  }) async {
    final result = await _repo.addAttachment(
      memoryId: memoryId,
      type: type,
      relativePath: relativePath,
      sizeBytes: sizeBytes,
    );
    result.fold(
      (error) => emit(AddMemoryError(error.messageKey)),
      (_) {},
    );
  }

  /// Resets to [AddMemoryInitial] so the form can be reused in the same session.
  void reset() {
    _selectedAttachments.clear();
    emit(const AddMemoryInitial());
  }

  AttachmentType? _attachmentType(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return AttachmentType.pdf;
      case 'docx':
        return AttachmentType.docx;
      case 'mp3':
        return AttachmentType.audio;
      case 'jpg':
      case 'jpeg':
        return AttachmentType.jpg;
      case 'png':
        return AttachmentType.png;
      case 'mp4':
        return AttachmentType.video;
      default:
        return null;
    }
  }
}
