import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'app_toast_state.dart';

@LazySingleton()
class AppToastCubit extends Cubit<AppToastState> {
  AppToastCubit() : super(const AppToastState());
  void _show(String text, ToastType type) {
    emit(AppToastState(id: state.id + 1, text: text, type: type));
  }

  void success(String text) => _show(text, ToastType.success);
  void error(String text) => _show(text, ToastType.error);
  void info(String text) => _show(text, ToastType.info);
  void warning(String text) => _show(text, ToastType.warning);
}
