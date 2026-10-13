import '../utils/file_type.dart';

class AttachmentModel {
  final String memoryId;
  final String attachmentId;
  final String fileName;
  final String fileSize;
  final FileType type;

  AttachmentModel({
    required this.memoryId,
    required this.attachmentId,
    required this.fileName,
    required this.fileSize,
    required this.type,
  });
}

/// TODO: Remove this later
/// Mock files data
final List<AttachmentModel> mockAttachments = [
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_1',
    fileName: 'medical_report_2024.pdf',
    fileSize: '1.4 MB',
    type: FileType.pdf,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_2',
    fileName: 'prescription_scan.png',
    fileSize: '840 KB',
    type: FileType.png,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_3',
    fileName: 'doctor_notes_recording.mp3',
    fileSize: '2.5 MB',
    type: FileType.audio,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_4',
    fileName: 'insurance_policy_terms.docx',
    fileSize: '420 KB',
    type: FileType.docx,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_5',
    fileName: 'family_celebration_clip.mp4',
    fileSize: '16.8 MB',
    type: FileType.video,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_6',
    fileName: 'pharmacy_receipt.jpg',
    fileSize: '1.1 MB',
    type: FileType.jpg,
  ),
];
