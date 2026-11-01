// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      memoryId: (json['memoryId'] as num).toInt(),
      attachmentId: (json['attachmentId'] as num).toInt(),
      fileName: json['fileName'] as String,
      sizeBytes: (json['sizeBytes'] as num).toInt(),
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'memoryId': instance.memoryId,
      'attachmentId': instance.attachmentId,
      'fileName': instance.fileName,
      'sizeBytes': instance.sizeBytes,
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
