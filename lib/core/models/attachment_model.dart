import 'package:json_annotation/json_annotation.dart';

import '../utils/enums.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel {
  final int memoryId;
  final int attachmentId;
  final String fileName;
  final int sizeBytes;
  final AttachmentType type;

  AttachmentModel({
    required this.memoryId,
    required this.attachmentId,
    required this.fileName,
    required this.sizeBytes,
    required this.type,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}
