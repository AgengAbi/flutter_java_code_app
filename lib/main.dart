import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/configs/themes/app_theme.dart';
import 'package:flutter_java_code_app/firebase_options.dart';
import 'package:flutter_java_code_app/shared/bindings/global_bindings.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:flutter_java_code_app/utils/services/translation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:hive_flutter/adapters.dart';

import 'configs/pages/page.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  // Translation ini
  await AppTranslation.loadTranslations();

  // Localstorage init
  await Hive.initFlutter();
  LocalStorageService.initHive();

  /// Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://439a7c1ded68520615134a7a6b201bb9@o4508646211911680.ingest.us.sentry.io/4508646320373760';
  //     options.tracesSampleRate = 1.0;
  //     options.profilesSampleRate = 1.0;
  //     // options.beforeSend = filterSentryErrorBeforeSend;
  //   },
  //   appRunner: () => runApp(const MyApp()),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Venturo Core',
          debugShowCheckedModeBanner: false,
          translations: AppTranslation(),
          locale: const Locale('id'),
          fallbackLocale: const Locale('id'),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('id'),
          ],
          initialBinding: GlobalBinding(),
          initialRoute: Routes.splashRoute,
          defaultTransition: Transition.native,
          getPages: Pages.pages,
          builder: EasyLoading.init(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.theme,
        );
      },
    );
  }
}
