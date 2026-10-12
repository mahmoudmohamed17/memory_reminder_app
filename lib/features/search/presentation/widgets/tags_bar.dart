import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class TagsBar extends StatefulWidget {
  final Function(String value) onTagSelected;

  const TagsBar({super.key, required this.onTagSelected});

  @override
  State<TagsBar> createState() => _TagsBarState();
}

class _TagsBarState extends State<TagsBar> {
  final ValueNotifier<int?> _current = ValueNotifier(null);

  List<String> get _labels => [
    AppStrings.categoriesAll,
    AppStrings.categoriesMedical,
    AppStrings.categoriesFinancial,
    AppStrings.categoriesFriends,
    AppStrings.categoriesFamily,
    AppStrings.categoriesPersonal,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.w,
        children: List.generate(_labels.length, (index) {
          return ValueListenableBuilder(
            valueListenable: _current,
            builder: (context, currentIndex, child) {
              final bool isSelected = currentIndex == index;
              return GestureDetector(
                onTap: () {
                  if (isSelected) return;
                  _current.value = index;
                  widget.onTagSelected.call(_labels[index]);
                },
                child: _bagde(
                  context,
                  label: _labels[index],
                  isActive: isSelected,
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _bagde(BuildContext context, {required String label, required bool isActive}) {
    return AnimatedContainer(
      duration: AppMotion.fast,
      decoration: BoxDecoration(
        color: isActive ? context.colorScheme.primary : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: isActive ? null : Border.all(color: context.colorScheme.primary),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      child: Text(
        context.tr(label),
        style: context.textTheme.labelMedium?.copyWith(
          color: isActive ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
        ),
      ),
    );
  }
}
