import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/models/memory_item_model.dart';
import 'memory_item.dart';

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
              5,
              (index) => MemoryItem(
                item: mockMemories[index],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
