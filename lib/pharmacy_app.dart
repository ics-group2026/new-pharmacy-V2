import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/router.dart';
import 'core/themes/theme_cubit/theme_cubit.dart';
import 'core/utils/snack_bar_helper.dart';

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp.router(
              scaffoldMessengerKey: rootScaffoldMessengerKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: state,
              routerConfig: appRouter,
            ),
          ),
        );
      },
    );
  }
}
