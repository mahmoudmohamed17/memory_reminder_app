import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as context;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/models/memory_model.dart';
import '../../../../core/widgets/memory_item.dart';

class MemoriesList extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        _header(context, mockMemories.length),

        // TODO: Remove this mock data and handle this with a Cubit/Bloc later
        mockMemories.isEmpty ? _empty(context) : _buildList(context, mockMemories),
      ],
    );
  }

  Widget _header(BuildContext context, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tr(AppStrings.homeMemoriesTitle),
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        if (count > 0)
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
    );
  }

  Widget _buildList(BuildContext context, List<MemoryModel> memories) {
    return Column(
      spacing: 8.h,
      children: memories.take(5).map<Widget>((item) => MemoryItem(item: item)).toList(),
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
          const FaIcon(FontAwesomeIcons.lightbulb),
          Text(
            context.tr(AppStrings.homeNoMemories),
            style: context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
