import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgrnColor;
  final Color? textColor;
  final Widget? icon;
  final double borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgrnColor,
    this.textColor,
    this.borderRadius = 16,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: context.theme.elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(backgrnColor),
        ),
        icon: icon,
        label: Text(
          context.tr(text),
          style: context.textTheme.titleMedium?.copyWith(
            color: textColor ?? context.colorScheme.onSurface,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
