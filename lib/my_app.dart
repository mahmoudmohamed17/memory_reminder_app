import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cubits/app_flow_cubit.dart';
import 'core/cubits/theme_cubit.dart';
import 'core/di/di.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

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
            // AppFlowCubit is already initialised; expose it so any widget
            // (e.g. OnboardingScreen) can call completeOnboarding().
            BlocProvider(create: (_) => getIt<AppFlowCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                themeMode: state,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeAnimationDuration: const Duration(milliseconds: 1500),
                themeAnimationCurve: Curves.fastOutSlowIn,
                routerConfig: AppRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}
