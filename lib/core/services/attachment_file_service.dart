import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Owns every attachment file on disk.
/// The DB only stores the RELATIVE path this service returns.
abstract class AttachmentFileService {
  /// Copies [source] into the app's private storage and returns the
  /// relative path to store in the DB (e.g. `attachments/1700000000_ab12.jpg`).
  Future<String> save(File file);

  /// Turns a stored relative path back into a real [File].
  Future<File> resolve(String relativePath);

  /// Deletes one file. Never throws: a missing or locked file must not
  /// break the DB operation that triggered the cleanup.
  Future<void> delete(String relativePath);

  Future<void> deleteAll(Iterable<String> relativePaths);
}

@LazySingleton(as: AttachmentFileService)
class AttachmentFileServiceImpl implements AttachmentFileService {
  static const _folder = 'attachments';
  final _random = Random();

  Future<Directory> _baseDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, _folder));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  @override
  Future<void> delete(String relativePath) async {
    try {
      final file = await resolve(relativePath);
      if (await file.exists()) await file.delete();
    } on FileSystemException catch (e) {
      dev.log('Could not delete $relativePath: $e', name: 'AttachmentFiles');
    }
  }

  @override
  Future<void> deleteAll(Iterable<String> relativePaths) async {
    for (final path in relativePaths) {
      await delete(path);
    }
  }

  @override
  Future<File> resolve(String relativePath) async {
    final docs = await getApplicationDocumentsDirectory();
    return File(p.join(docs.path, relativePath));
  }

  @override
  Future<String> save(File file) async {
    final dir = await _baseDir();
    final name =
        '${DateTime.now().millisecondsSinceEpoch}'
        '_${_random.nextInt(0xFFFF).toRadixString(16)}'
        '${p.extension(file.path)}';
    await file.copy(p.join(dir.path, name));
    return p.join(_folder, name);
  }
}
