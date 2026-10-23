import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/memory_category_selection_widget.dart';
import '../../cubits/add_memory_cubit.dart';
import 'memory_attachments_widget.dart';

class MemoryCreationBottomSheet extends StatefulWidget {
  const MemoryCreationBottomSheet({super.key});

  @override
  State<MemoryCreationBottomSheet> createState() => _MemoryCreationBottomSheetState();
}

class _MemoryCreationBottomSheetState extends State<MemoryCreationBottomSheet> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MemoryCategory _selectedCategory = MemoryCategory.other;

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
    return BlocListener<AddMemoryCubit, AddMemoryState>(
      listener: (context, state) {
        if (state is AddMemorySuccess) {
          context.pop();
        } else if (state is AddMemoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
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
                onSelected: (category) => _selectedCategory = category,
              ),
              const MemoryAttachmentsWidget(),
              BlocSelector<AddMemoryCubit, AddMemoryState, bool>(
                selector: (state) => state is AddMemoryLoading,
                builder: (context, isLoading) {
                  return CustomElevatedButton(
                    text: AppStrings.addMemorySave,
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AddMemoryCubit>().addMemory(
                                    title: _title.text,
                                    description: _description.text,
                                    category: _selectedCategory,
                                  );
                            }
                          },
                    icon: isLoading
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.lock),
                    iconAlignment: IconAlignment.end,
                    width: double.infinity,
                  );
                },
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 8.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: _title,
            hint: AppStrings.addMemoryNamePlaceholder,
            label: AppStrings.addMemoryNameLabel,
            validator: (value) {
              final error = Validators.requiredField(value);
              return error != null ? context.tr(error) : null;
            },
          ),
          CustomTextFormField(
            controller: _description,
            hint: AppStrings.addMemoryDetailsPlaceholder,
            label: AppStrings.addMemoryDetailsLabel,
            validator: (value) {
              final error = Validators.requiredField(value);
              return error != null ? context.tr(error) : null;
            },
          ),
        ],
      ),
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
