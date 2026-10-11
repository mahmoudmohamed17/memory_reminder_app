import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/change_langauge_button.dart';
import '../../../../core/widgets/change_theme_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../domain/models/memory_item_model.dart';
import '../wigdets/greeting_widget.dart';
import '../wigdets/memories_list.dart';
import '../wigdets/memory_item_creation_bottom_sheet.dart';
import '../wigdets/voice_searching_button.dart';

class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            children: [
              Row(
                spacing: 12.w,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [ChangeThemeButton(), ChangeLangaugeButton()],
              ),
              Expanded(
                child: ListView(
                  children: [
                    16.verticalSpace,
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GreetingWidget(),
                    ),
                    16.verticalSpace,
                    const CustomTextFormField(
                      hint: AppStrings.homeSearchPlaceholder,
                      prefixIcon: Icon(Icons.search),
                    ),
                    16.verticalSpace,
                    const VoiceSearchingButton(),
                    16.verticalSpace,
                    const MemoriesList(),
                    64.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<MemoryItemModel>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => const MemoryItemCreationBottomSheet(),
          ).then((item) {
            if (item == null) return;

            /// Handle adding the item using a Cubit
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
