import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/attachment_model.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class AttachmentsWidget extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          context.tr(AppStrings.memoryAttachments),
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.outline,
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          physics: const NeverScrollableScrollPhysics(),
          children: mockAttachments.map((item) => _file(context, item)).toList(),
        ),
      ],
    );
  }

  Widget _file(BuildContext context, AttachmentModel model) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: model.type.colors.tint,
              ),
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Icon(model.type.icon, color: model.type.colors.base),
            ),
          ),
          Text(
            model.fileName,
            style: context.textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            spacing: 4,
            children: [
              Text(
                model.type.label.toUpperCase(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
              CircleAvatar(
                radius: 2,
                backgroundColor: context.colorScheme.outline,
              ),
              Text(
                model.fileSize,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
