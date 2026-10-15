import 'dart:ui';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../utils/app_keys.dart';
import '../utils/locale_manager.dart';

/// Manages the active locale by cycling through [LocaleManager.supportedLocales].
///
/// Using an index-based approach means adding a new locale only requires
/// updating [LocaleManager.supportedLocales] — no changes needed here.
@Singleton()
class LocaleCubit extends HydratedCubit<Locale> {
  LocaleCubit() : super(LocaleManager.initialLocale);

  /// Advances to the next locale in [LocaleManager.supportedLocales],
  /// wrapping back to index 0 after the last one.
  void cycleLocale() {
    final locales = LocaleManager.supportedLocales;
    final currentIndex = locales.indexOf(state);
    final nextIndex = (currentIndex + 1) % locales.length;
    emit(locales[nextIndex]);
  }

  /// Jumps directly to a specific locale (e.g. from a settings picker).
  void setLocale(Locale locale) {
    assert(
      LocaleManager.supportedLocales.contains(locale),
      'Locale $locale is not in LocaleManager.supportedLocales',
    );
    emit(locale);
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    final index = json[AppKeys.localeIndex] as int?;
    if (index == null) return null;
    final locales = LocaleManager.supportedLocales;
    if (index < 0 || index >= locales.length) return null;
    return locales[index];
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    final index = LocaleManager.supportedLocales.indexOf(state);
    if (index == -1) return null;
    return {AppKeys.localeIndex: index};
  }
}
