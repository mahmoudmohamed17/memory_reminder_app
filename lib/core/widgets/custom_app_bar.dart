import 'package:flutter/material.dart';

AppBar customAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  bool centerTitle = false,
  bool automaticallyImplyLeading = false,
  TextStyle? titleTextStyle,
  double elevation = 0,
}) {
  return AppBar(
    title: title,
    titleTextStyle: titleTextStyle,
    elevation: elevation,
    leading: leading,
    actions: actions,
    automaticallyImplyLeading: automaticallyImplyLeading,
    centerTitle: centerTitle,
  );
}
