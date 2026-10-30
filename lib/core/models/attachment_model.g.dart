// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) => AttachmentModel(
  memoryId: json['memoryId'] as String,
  attachmentId: json['attachmentId'] as String,
  fileName: json['fileName'] as String,
  fileSize: json['fileSize'] as String,
  type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
);

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) => <String, dynamic>{
  'memoryId': instance.memoryId,
  'attachmentId': instance.attachmentId,
  'fileName': instance.fileName,
  'fileSize': instance.fileSize,
  'type': _$AttachmentTypeEnumMap[instance.type]!,
};

const _$AttachmentTypeEnumMap = {
  AttachmentType.pdf: 'pdf',
  AttachmentType.docx: 'docx',
  AttachmentType.audio: 'audio',
  AttachmentType.jpg: 'jpg',
  AttachmentType.png: 'png',
  AttachmentType.video: 'video',
};
