import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/cubits/app_toast_cubit.dart';
import '../../../../core/models/memory_model.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/memory_category_selection_widget.dart';
import '../cubits/edit_memory_cubit.dart';

class EditMemoryScreen extends StatefulWidget {
  final MemoryModel model;

  const EditMemoryScreen({super.key, required this.model});

  @override
  State<EditMemoryScreen> createState() => _EditMemoryScreenState();
}

class _EditMemoryScreenState extends State<EditMemoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late MemoryCategory _selectedCategory;
  final ValueNotifier<bool> _isModelUpdated = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.model.category;
    _title = TextEditingController(text: widget.model.title)..addListener(_checkIfUpdated);
    _description = TextEditingController(text: widget.model.description)..addListener(_checkIfUpdated);
  }

  void _checkIfUpdated() {
    final titleChanged = _title.text.trim() != widget.model.title.trim();
    final descriptionChanged = _description.text.trim() != widget.model.description.trim();
    final categoryChanged = _selectedCategory != widget.model.category;

    final hasChanges = titleChanged || descriptionChanged || categoryChanged;
    final isNotEmpty = _title.text.trim().isNotEmpty && _description.text.trim().isNotEmpty;

    _isModelUpdated.value = hasChanges && isNotEmpty;
  }

  void _onUpdate() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<EditMemoryCubit>().updateMemory(
      id: widget.model.id,
      title: _title.text.trim(),
      description: _description.text.trim(),
      category: _selectedCategory,
    );
  }

  @override
  void dispose() {
    _isModelUpdated.dispose();
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditMemoryCubit, EditMemoryState>(
      listener: (context, state) {
        if (state is EditMemorySuccess) {
          context.pop();
          context.read<AppToastCubit>().success(context.tr(AppStrings.editMemoryUpdatedSuccessfully));
        } else if (state is EditMemoryError) {
          context.read<AppToastCubit>().error(context.tr(AppStrings.errorMemoryUpdateFailed));
        }
      },
      child: Scaffold(
        appBar: customAppBar(
          title: Text(context.tr(AppStrings.editMemoryTitle)),
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            _form(context),
            18.verticalSpace,
            MemoryCategorySelectionWidget(
              initialCategory: widget.model.category,
              onSelected: (category) {
                _selectedCategory = category;
                _checkIfUpdated();
              },
              gridItemColor: context.colorScheme.surfaceContainerHigh,
            ),
            48.verticalSpace,
            ValueListenableBuilder<bool>(
              valueListenable: _isModelUpdated,
              builder: (context, isUpdated, child) {
                return BlocSelector<EditMemoryCubit, EditMemoryState, bool>(
                  selector: (state) => state is EditMemoryLoading,
                  builder: (context, isLoading) {
                    return CustomElevatedButton(
                      onPressed: (isUpdated && !isLoading) ? _onUpdate : null,
                      width: double.infinity,
                      text: AppStrings.editMemoryUpdate,
                      icon: isLoading
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check),
                      backgroundColor: (isUpdated && !isLoading)
                          ? null
                          : WidgetStatePropertyAll(context.colorScheme.surfaceContainerHighest),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
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
            maxLines: null,
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
}
