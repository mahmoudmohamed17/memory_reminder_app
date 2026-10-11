import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class MemoryAttachmentsWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(16.r),
        padding: EdgeInsets.zero,
        color: context.colorScheme.outline.withValues(alpha: 0.50),
        dashPattern: [7, 5],
      ),
      child: ListTile(
        title: Text(
          context.tr(AppStrings.addMemoryAttachmentTitle),
        ),
        subtitle: Text(
          context.tr(AppStrings.addMemoryAttachmentTypes),
          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
        ),
        trailing: const Icon(Icons.attachment),
      ),
    );
  }
}
