part of 'app_toast_cubit.dart';

enum ToastType { info, warning, success, error }

class AppToastState extends Equatable {
  final int id;
  final String? text;
  final ToastType type;

  const new({
    this.id = 0,
    this.text,
    this.type = ToastType.info,
  });

  @override
  List<Object?> get props => [id, text, type];
}
