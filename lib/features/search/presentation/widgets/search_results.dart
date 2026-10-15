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
        _header(context, mockMemories.length),

        // TODO: Handle this using a Cubit/Bloc later
        // _emptySearch(context),
        _results(mockMemories),
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

  Widget _header(BuildContext context, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(AppStrings.searchResultsTitle),
          style: context.textTheme.labelLarge,
        ),
        Text(
          context.tr(AppStrings.searchResultsCount, namedArgs: {'count': count.toString()}),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget _emptySearch(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outlineVariant),
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
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
    );
  }
}
