import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/models/memory_model.dart';
import '../../cubits/memory_details_cubit.dart';
import '../wigdets/attachments_widget.dart';
import '../wigdets/description_widget.dart';
import '../wigdets/details_footer.dart';
import '../wigdets/details_header.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final MemoryModel model;

  const MemoryDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoryDetailsCubit, MemoryDetailsState>(
      listener: (context, state) {
        if (state is MemoryDetailsDeleted) {
          context.pop();
        } else if (state is MemoryDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<MemoryDetailsCubit, MemoryDetailsState>(
        builder: (context, state) {
          // Use the live model if available, otherwise fall back to the initial
          // model passed via navigation (avoids a blank frame on first load).
          final current = state is MemoryDetailsLoaded ? state.memory : model;

          return Scaffold(
            appBar: customAppBar(
              title: Text(context.tr(AppStrings.memoryDetailsLabel)),
              automaticallyImplyLeading: true,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    await context.push<void>(AppRoutes.memoryEdit, extra: current);
                  },
                  icon: const FaIcon(FontAwesomeIcons.penToSquare),
                  tooltip: context.tr(AppStrings.edit),
                ),
                4.horizontalSpace,
              ],
            ),
            body: switch (state) {
              MemoryDetailsLoading() => const Center(child: CircularProgressIndicator()),
              MemoryDetailsDeleted() => const SizedBox.shrink(),
              _ => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  children: [
                    DetailsHeader(model: current),
                    16.verticalSpace,
                    DescriptionWidget(description: current.description),
                    16.verticalSpace,
                    const AttachmentsWidget(),
                    16.verticalSpace,
                    DetailsFooter(creationDate: current.creationDate),
                    32.verticalSpace,
                  ],
                ),
            },
          );
        },
      ),
    );
  }
}
