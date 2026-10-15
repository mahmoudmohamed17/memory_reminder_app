import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/app_colors.dart';

enum FileType {
  pdf(label: 'PDF', icon: FontAwesomeIcons.filePdf, colors: MemoryFileColor.pdf),
  docx(label: 'DOCX', icon: FontAwesomeIcons.fileWord, colors: MemoryFileColor.docx),
  audio(label: 'MP3', icon: FontAwesomeIcons.itunesNote, colors: MemoryFileColor.audio),
  jpg(label: 'JPG', icon: FontAwesomeIcons.image, colors: MemoryFileColor.image),
  png(label: 'PNG', icon: FontAwesomeIcons.image, colors: MemoryFileColor.image),
  video(label: 'MP4', icon: FontAwesomeIcons.video, colors: MemoryFileColor.video);

  final String label;
  final FaIconData icon;
  final MemoryFileColor colors;

  const FileType({
    required this.label,
    required this.icon,
    required this.colors,
  });
}
