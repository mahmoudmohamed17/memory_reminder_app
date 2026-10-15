import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../utils/shared_prefs_helper.dart';
import 'app_flow_state.dart';

@Singleton()
class AppFlowCubit extends Cubit<AppFlowState> {
  AppFlowCubit(this._prefs) : super(_resolve(_prefs));

  final SharedPrefsHelper _prefs;

  static const _onboardingKey = 'onboarding_completed';

  /// Derives the correct initial state from persisted preferences.
  static AppFlowState _resolve(SharedPrefsHelper prefs) {
    final done = prefs.getBool(_onboardingKey);
    return done ? AppFlowState.home : AppFlowState.onboarding;
  }

  /// Marks onboarding as complete, persists the flag, and moves to [home].
  /// GoRouter's refreshListenable will re-evaluate the redirect automatically.
  void completeOnboarding() {
    _prefs.setBool(key: _onboardingKey, value: true);
    emit(AppFlowState.home);
  }
}
