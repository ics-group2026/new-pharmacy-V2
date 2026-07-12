import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/constants.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/prefs.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/setup_service_locator.dart';
import 'core/themes/theme_cubit/theme_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';
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
  // Honor "Remember me": if the user opted out, don't carry the session across
  // cold starts — clear tokens so the go_router redirect lands on login.
  final optedOut =
      Prefs.containsKey(kRememberMe) && !Prefs.getBool(kRememberMe);
  if (optedOut && Prefs.getString(kToken) != null) {
    getIt<AuthRepo>().clearTokens();
  }
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/lang',
      startLocale: Locale("en"),
      fallbackLocale: Locale("en"),
      saveLocale: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()..getCurrentTheme()),
          BlocProvider(create: (_) => WishlistCubit()),
          BlocProvider(create: (_) => CartCubit()),
        ],
        child: const PharmacyApp(),
      ),
    ),
  );
}
