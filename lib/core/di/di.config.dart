// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../cubits/app_flow_cubit.dart' as _i49;
import '../cubits/theme_cubit.dart' as _i525;
import '../utils/shared_prefs_helper.dart' as _i964;
import 'modules.dart' as _i738;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final modules = _$Modules();
    gh.singleton<_i525.ThemeCubit>(() => _i525.ThemeCubit());
    gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => modules.sharedPreferences,
    );
    gh.lazySingletonAsync<_i964.SharedPrefsHelper>(
      () async =>
          _i964.SharedPrefsHelper(await getAsync<_i460.SharedPreferences>()),
    );
    gh.singletonAsync<_i49.AppFlowCubit>(
      () async => _i49.AppFlowCubit(await getAsync<_i964.SharedPrefsHelper>()),
    );
    return this;
  }
}

class _$Modules extends _i738.Modules {}
