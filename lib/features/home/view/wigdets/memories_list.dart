import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/resolve_memory_icon.dart';
import '../../domain/models/memory_item_model.dart';

class MemoriesList extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(AppStrings.homeMemoriesTitle),
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                spacing: 4.w,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.tr(AppStrings.homeViewAll),
                    style: context.textTheme.titleSmall,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        ...[
          Column(
            spacing: 8.h,
            children: List.generate(
              mockMemories.length,
              (index) => _item(
                context,
                mockMemories[index],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _item(BuildContext context, MemoryItemModel item) {
    final colors = context.appColors.category(item.category);
    final icon = resolveMemoryIcon(item.category);

    return Card(
      child: ListTile(
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: colors.tint,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            icon,
            color: colors.base,
          ),
        ),
        title: Text(
          item.title,
          style: context.textTheme.labelSmall?.copyWith(color: colors.base),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item.description,
          style: context.textTheme.titleSmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 18.sp,
          color: context.colorScheme.outline.withValues(alpha: 0.50),
        ),
      ),
    );
  }
}
