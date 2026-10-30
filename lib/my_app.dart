import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import 'core/cubits/app_flow_cubit.dart';
import 'core/cubits/app_toast_cubit.dart';
import 'core/cubits/locale_cubit.dart';
import 'core/cubits/theme_cubit.dart';
import 'core/di/di.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/show_toast.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ThemeCubit>()),
            BlocProvider(create: (_) => getIt<AppFlowCubit>()),
            BlocProvider(create: (_) => getIt<LocaleCubit>()),
            BlocProvider(create: (_) => getIt<AppToastCubit>()),
          ],
          child: BlocListener<LocaleCubit, Locale>(
            listener: (context, locale) => context.setLocale(locale),
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return ToastificationWrapper(
                  child: BlocListener<AppToastCubit, AppToastState>(
                    listener: (context, state) {
                      showToast(
                        title: Text(state.text!),
                        type: switch (state.type) {
                          ToastType.success => ToastificationType.success,
                          ToastType.error => ToastificationType.error,
                          ToastType.warning => ToastificationType.warning,
                          ToastType.info => ToastificationType.info,
                        },
                      );
                    },
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      themeMode: themeMode,
                      theme: AppTheme.light,
                      darkTheme: AppTheme.dark,
                      themeAnimationDuration: const Duration(milliseconds: 1500),
                      themeAnimationCurve: Curves.fastOutSlowIn,
                      routerConfig: AppRouter.router,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
