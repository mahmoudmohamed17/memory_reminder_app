import 'package:json_annotation/json_annotation.dart';

import '../utils/enums.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel {
  final String memoryId;
  final String attachmentId;
  final String fileName;
  final String fileSize;
  final AttachmentType type;

  AttachmentModel({
    required this.memoryId,
    required this.attachmentId,
    required this.fileName,
    required this.fileSize,
    required this.type,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}

/// TODO: Remove this later
/// Mock files data
final List<AttachmentModel> mockAttachments = [
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_1',
    fileName: 'medical_report_2024.pdf',
    fileSize: '1.4 MB',
    type: AttachmentType.pdf,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_2',
    fileName: 'prescription_scan.png',
    fileSize: '840 KB',
    type: AttachmentType.png,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_3',
    fileName: 'doctor_notes_recording.mp3',
    fileSize: '2.5 MB',
    type: AttachmentType.audio,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_4',
    fileName: 'insurance_policy_terms.docx',
    fileSize: '420 KB',
    type: AttachmentType.docx,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_5',
    fileName: 'family_celebration_clip.mp4',
    fileSize: '16.8 MB',
    type: AttachmentType.video,
  ),
  AttachmentModel(
    memoryId: '1',
    attachmentId: 'att_6',
    fileName: 'pharmacy_receipt.jpg',
    fileSize: '1.1 MB',
    type: AttachmentType.jpg,
  ),
];
