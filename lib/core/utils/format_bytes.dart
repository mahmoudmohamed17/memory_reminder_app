import 'dart:math';

String formatBytes(int bytes, {int decimals = 1}) {
  if (bytes <= 0) return '0 B';

  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
  final i = (log(bytes) / log(1024)).floor().clamp(0, suffixes.length - 1);
  final size = bytes / pow(1024, i);

  return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
}
