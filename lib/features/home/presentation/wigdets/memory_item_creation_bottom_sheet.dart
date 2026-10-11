import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'memory_attachments_widget.dart';
import 'memory_category_selection_widget.dart';

class MemoryItemCreationBottomSheet extends StatefulWidget {
  const MemoryItemCreationBottomSheet({super.key});

  @override
  State<MemoryItemCreationBottomSheet> createState() => _MemoryItemCreationBottomSheetState();
}

class _MemoryItemCreationBottomSheetState extends State<MemoryItemCreationBottomSheet> {
  late final TextEditingController _title;
  late final TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            _header(context),
            _form(),
            MemoryCategorySelectionWidget(
              onSelected: (category) {},
            ),
            const MemoryAttachmentsWidget(),
            CustomElevatedButton(
              text: AppStrings.addMemorySave,
              onPressed: () {},
              icon: const Icon(Icons.lock),
              iconAlignment: IconAlignment.end,
              width: double.infinity,
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Column(
      spacing: 8.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFormField(
          controller: _title,
          hint: AppStrings.addMemoryNamePlaceholder,
          label: AppStrings.addMemoryNameLabel,
        ),
        CustomTextFormField(
          controller: _description,
          hint: AppStrings.addMemoryDetailsPlaceholder,
          label: AppStrings.addMemoryDetailsLabel,
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return ListTile(
      title: Text(
        context.tr(AppStrings.addMemoryTitle),
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        context.tr(AppStrings.addMemorySubtitle),
        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
      ),
      trailing: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.primaryContainer,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(8.sp),
          child: const Icon(Icons.close),
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
