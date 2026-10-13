import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class DetailsFooter extends StatelessWidget {
  final DateTime creationDate;

  const new({super.key, required this.creationDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tile(
          context,
          icon: Icons.calendar_month_rounded,
          title: Text(
            context.tr(AppStrings.memoryCreatedAt),
            style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.outline),
          ),
          subTitle: Text(
            creationDate.toIso8601String(),
            style: context.textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _tile(
          context,
          icon: Icons.shield_outlined,
          title: Text(
            context.tr(AppStrings.memoryLocalData),
            style: context.textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    Widget? title,
    Widget? subTitle,
  }) {
    return Expanded(
      child: ListTile(
        horizontalTitleGap: 8,
        leading: Icon(icon),
        title: title,
        subtitle: subTitle,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
