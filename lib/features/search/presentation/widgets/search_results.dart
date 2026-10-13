import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/memory_item.dart';
import '../../../../core/models/memory_model.dart';

class SearchResults extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.h,
      children: [
        _header(context),
        _emptySearch(context),
        // _results(mockMemories),
      ],
    );
  }

  Widget _results(List<MemoryModel> results) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, index) {
          return MemoryItem(item: results[index]);
        },
        separatorBuilder: (_, _) => 16.verticalSpace,
        itemCount: results.length,
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(AppStrings.searchResultsTitle),
          style: context.textTheme.labelLarge,
        ),
        Text(
          context.tr(AppStrings.searchResultsCount, namedArgs: {'count': '6'}),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _emptySearch(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(16.r),
        padding: EdgeInsets.all(24.sp),
        color: context.colorScheme.outlineVariant,
        dashPattern: [7, 4],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 4.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(12.sp),
              child: const Icon(Icons.search),
            ),
            Text(
              context.tr(AppStrings.searchEmptyTitle),
              style: context.textTheme.labelLarge,
            ),
            Text(
              context.tr(AppStrings.searchEmptyDescription),
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
