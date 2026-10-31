import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/repositories/memory_repository.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../cubits/add_memory_cubit.dart';
import 'memory_input_attachment_widget.dart';

class MemoryAttachmentsWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMemoryCubit, AddMemoryState>(
      buildWhen: (_, state) => state is AddMemoryAttachmentsUpdated || state is AddMemoryInitial,
      builder: (context, state) {
        final List<MemoryAttachmentInput> attachments = state is AddMemoryAttachmentsUpdated ? state.attachments : [];
        if (attachments.isEmpty) return _empty(context);

        final List<Widget> items = attachments.map<Widget>((item) => MemoryInputAttachmentWidget(input: item)).toList()
          ..add(_addMore(context));

        return GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 0.85,
          children: items,
        );
      },
    );
  }

  Widget _empty(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AddMemoryCubit>().pickAttachments(),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16.r),
          padding: EdgeInsets.zero,
          color: context.colorScheme.outline.withValues(alpha: 0.50),
          dashPattern: [7, 5],
        ),
        child: ListTile(
          title: Text(context.tr(AppStrings.addMemoryAttachmentTitle)),
          subtitle: Text(
            context.tr(AppStrings.addMemoryAttachmentTypes),
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
          ),
          trailing: const Icon(Icons.attachment),
        ),
      ),
    );
  }

  Widget _addMore(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AddMemoryCubit>().pickAttachments(),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16.r),
          color: context.colorScheme.outline,
          dashPattern: [7, 5],
        ),
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.plus,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
