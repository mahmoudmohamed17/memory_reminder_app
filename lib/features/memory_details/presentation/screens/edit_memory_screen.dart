import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/memory_model.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class EditMemoryScreen extends StatefulWidget {
  final MemoryModel model;

  const EditMemoryScreen({super.key, required this.model});

  @override
  State<EditMemoryScreen> createState() => _EditMemoryScreenState();
}

class _EditMemoryScreenState extends State<EditMemoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: Text(context.tr(AppStrings.editMemoryTitle)),
        automaticallyImplyLeading: true,
      ),
    );
  }
}
