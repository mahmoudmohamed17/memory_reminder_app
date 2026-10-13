import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/models/memory_model.dart';
import '../wigdets/attachments_widget.dart';
import '../wigdets/description_widget.dart';
import '../wigdets/details_footer.dart';
import '../wigdets/details_header.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final MemoryModel model;

  const MemoryDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: Text(context.tr(AppStrings.memoryDetailsLabel)),
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push(AppRoutes.memoryEdit, extra: model);
            },
            icon: const FaIcon(FontAwesomeIcons.penToSquare),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          DetailsHeader(model: model),
          16.verticalSpace,
          DescriptionWidget(description: model.description),
          16.verticalSpace,
          const AttachmentsWidget(),
          16.verticalSpace,
          DetailsFooter(creationDate: model.creationDate),
          32.verticalSpace,
        ],
      ),
    );
  }
}
