import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/locale_cubit.dart';
import '../utils/extensions.dart';

class ChangeLangaugeButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LocaleCubit>().cycleLocale(),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: context.colorScheme.outline.withValues(alpha: 0.25),
          ),
        ),
        padding: EdgeInsets.all(10.sp),
        child: Icon(Icons.translate, size: 20.sp),
      ),
    );
  }
}
