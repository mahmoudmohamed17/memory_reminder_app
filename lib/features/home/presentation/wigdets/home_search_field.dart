import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../search/presentation/screens/search_screen.dart';

class HomeSearchField extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: OpenContainer(
            transitionDuration: const Duration(milliseconds: 500),
            closedElevation: 0,
            closedColor: context.theme.scaffoldBackgroundColor,
            openColor: context.theme.scaffoldBackgroundColor,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            closedBuilder: (context, openContainer) => const Material(
              color: Colors.transparent,
              child: IgnorePointer(
                child: CustomTextFormField(
                  hint: AppStrings.homeSearchPlaceholder,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            openBuilder: (context, closeContainer) => const SearchScreen(),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.mic,
            size: 34.sp,
          ),
        ),
      ],
    );
  }
}
