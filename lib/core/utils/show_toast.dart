import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({
  BuildContext? context,
  Widget? title,
  ToastificationType type = ToastificationType.info,
  ToastificationStyle style = ToastificationStyle.flat,
  CloseButtonShowType closeButton = CloseButtonShowType.none,
  bool showProgressBar = true,
  bool dragToClose = true,
  Duration autoCloseDuration = const Duration(seconds: 3),
}) {
  toastification.show(
    context: context,
    title: title,
    type: type,
    style: style,
    dragToClose: dragToClose,
    showProgressBar: showProgressBar,
    closeButton: ToastCloseButton(showType: closeButton),
    autoCloseDuration: autoCloseDuration,
  );
}
