import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/change_langauge_button.dart';
import '../../../../core/widgets/change_theme_button.dart';

class HomeHeader extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        ChangeThemeButton(),
        ChangeLangaugeButton(),
      ],
    );
  }
}
