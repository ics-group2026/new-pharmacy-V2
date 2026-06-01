import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/prefs.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/setup_service_locator.dart';
import 'core/themes/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';
import 'pharmacy_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationService.initialize();
  await LocalNotificationService.init();
  await Prefs.init();
  setupServiceLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/lang',
      startLocale: Locale("en"),
      fallbackLocale: Locale("en"),
      saveLocale: true,
      child: BlocProvider(
        create: (context) => ThemeCubit()..getCurrentTheme(),
        child: const PharmacyApp(),
      ),
    ),
  );
}
