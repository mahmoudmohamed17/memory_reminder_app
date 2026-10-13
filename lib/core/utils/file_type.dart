import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum FileType {
  pdf(label: 'PDF', icon: Icons.picture_as_pdf, colors: MemoryFileColor.pdf),
  docx(label: 'DOCX', icon: Icons.description, colors: MemoryFileColor.docx),
  audio(label: 'MP3', icon: Icons.voice_chat, colors: MemoryFileColor.audio),
  jpg(label: 'JPG', icon: Icons.image, colors: MemoryFileColor.image),
  png(label: 'PNG', icon: Icons.image, colors: MemoryFileColor.image),
  video(label: 'MP4', icon: Icons.video_call, colors: MemoryFileColor.video);

  final String label;
  final IconData icon;
  final MemoryFileColor colors;

  const FileType({
    required this.label,
    required this.icon,
    required this.colors,
  });
}
