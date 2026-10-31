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

import '../../features/home/cubits/add_memory_cubit.dart' as _i762;
import '../../features/home/cubits/memories_list_cubit.dart' as _i531;
import '../../features/memory_details/presentation/cubits/edit_memory_cubit.dart' as _i843;
import '../../features/memory_details/presentation/cubits/memory_details_cubit.dart'
    as _i463;
import '../../features/search/cubits/search_cubit.dart' as _i51;
import '../cubits/app_flow_cubit.dart' as _i49;
import '../cubits/app_toast_cubit.dart' as _i48;
import '../cubits/locale_cubit.dart' as _i867;
import '../cubits/theme_cubit.dart' as _i525;
import '../cubits/voice_recording_cubit.dart' as _i1068;
import '../database/app_database.dart' as _i982;
import '../database/daos/memories_dao.dart' as _i384;
import '../repositories/memory_repository.dart' as _i536;
import '../repositories/memory_repository_impl.dart' as _i775;
import '../services/attachment_file_service.dart' as _i159;
import '../services/voice_recording_service.dart' as _i262;
import '../utils/shared_prefs_helper.dart' as _i964;
import 'modules.dart' as _i738;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final modules = _$Modules();
    gh.singleton<_i867.LocaleCubit>(() => _i867.LocaleCubit());
    gh.singleton<_i525.ThemeCubit>(() => _i525.ThemeCubit());
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => modules.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i48.AppToastCubit>(() => _i48.AppToastCubit());
    gh.lazySingleton<_i982.AppDatabase>(
      () => _i982.AppDatabase(),
      dispose: (i) => i.close(),
    );
    gh.lazySingleton<_i262.VoiceRecordingService>(
      () => _i262.VoiceRecordingService(),
    );
    gh.lazySingleton<_i159.AttachmentFileService>(
      () => _i159.AttachmentFileServiceImpl(),
    );
    gh.lazySingleton<_i964.SharedPrefsHelper>(
      () => _i964.SharedPrefsHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1068.VoiceRecordingCubit>(
      () => _i1068.VoiceRecordingCubit(gh<_i262.VoiceRecordingService>()),
    );
    gh.lazySingleton<_i384.MemoriesDao>(
      () => modules.memoriesDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i536.MemoryRepository>(
      () => _i775.MemoryRepositoryImpl(
        gh<_i384.MemoriesDao>(),
        gh<_i159.AttachmentFileService>(),
      ),
    );
    gh.singleton<_i49.AppFlowCubit>(
      () => _i49.AppFlowCubit(gh<_i964.SharedPrefsHelper>()),
    );
    gh.factory<_i762.AddMemoryCubit>(
      () => _i762.AddMemoryCubit(gh<_i536.MemoryRepository>()),
    );
    gh.factory<_i531.MemoriesListCubit>(
      () => _i531.MemoriesListCubit(gh<_i536.MemoryRepository>()),
    );
    gh.factory<_i843.EditMemoryCubit>(
      () => _i843.EditMemoryCubit(gh<_i536.MemoryRepository>()),
    );
    gh.factory<_i463.MemoryDetailsCubit>(
      () => _i463.MemoryDetailsCubit(gh<_i536.MemoryRepository>()),
    );
    gh.factory<_i51.SearchCubit>(
      () => _i51.SearchCubit(gh<_i536.MemoryRepository>()),
    );
    return this;
  }
}

class _$Modules extends _i738.Modules {}
