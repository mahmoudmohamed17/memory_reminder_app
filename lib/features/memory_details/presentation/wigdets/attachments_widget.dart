import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/attachment_model.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class AttachmentsWidget extends StatelessWidget {
  const new({super.key});

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
        _empty(context),
        // GridView.count(
        //   shrinkWrap: true,
        //   crossAxisCount: 2,
        //   crossAxisSpacing: 8.w,
        //   mainAxisSpacing: 8.h,
        //   physics: const NeverScrollableScrollPhysics(),
        //   children: mockAttachments.map((item) => _file(context, item)).toList(),
        // ),
      ],
    );
  }

  // ignore: unused_element
  Widget _file(BuildContext context, AttachmentModel model) {
    return GestureDetector(
      onTap: () {
        // Open the file based on the file type
      },
      child: Container(
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
                alignment: Alignment.center,
                child: FaIcon(
                  model.type.icon,
                  color: model.type.colors.base,
                  size: 32.sp,
                ),
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
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          const FaIcon(FontAwesomeIcons.paperclip),
          Text(
            context.tr(AppStrings.memoryNoAttachments),
            style: context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
