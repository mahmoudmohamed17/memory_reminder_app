import 'dart:io';

import 'package:dartz/dartz.dart';

import 'app_error.dart';

export 'app_error.dart';

typedef Result<T> = Either<AppError, T>;

/// Converts storage and file-system exceptions into safe, localized app errors.
/// Raw exception messages are deliberately never exposed to the UI.
class ErrorHandler {
  ErrorHandler._();

  static AppError normalize(
    Object error, {
    required AppError Function(Object error) fallback,
  }) {
    if (error is AppError) return error;

    final description = error.toString().toLowerCase();
    if (description.contains('database disk image is malformed') ||
        description.contains('file is not a database') ||
        description.contains('database corruption')) {
      return AppError.databaseCorrupted(cause: error);
    }
    if (description.contains('disk is full') ||
        description.contains('no space left') ||
        (error is FileSystemException && (error.osError?.errorCode == 28 || error.osError?.errorCode == 112))) {
      return AppError.insufficientStorage(cause: error);
    }
    if (error is FileSystemException) {
      final code = error.osError?.errorCode;
      if (code == 2 || code == 3) return AppError.fileNotFound(cause: error);
      if (code == 5 || code == 13) return AppError.fileAccessDenied(cause: error);
    }

    return fallback(error);
  }
}
