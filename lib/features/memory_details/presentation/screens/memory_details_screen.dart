import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/domain/models/memory_item_model.dart';
import '../wigdets/attachments_widget.dart';
import '../wigdets/description_widget.dart';
import '../wigdets/details_footer.dart';
import '../wigdets/details_header.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final MemoryItemModel model;

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
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.penToSquare),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          bottom: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20.h,
            children: [
              DetailsHeader(model: model),
              DescriptionWidget(description: model.description),
              const AttachmentsWidget(),
              DetailsFooter(creationDate: model.creationDate),
            ],
          ),
        ),
      ),
    );
  }
}
