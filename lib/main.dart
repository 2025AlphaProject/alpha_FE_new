import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'components/bottom_navigation_bar/app_shell.dart';
import 'components/bottom_navigation_bar/navigation_binding.dart';
import 'init_controllers.dart';
import 'pages/login_page/login_page_indicator.dart';
import 'services/access_token/test_access_token.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  await dotenv.load();
  final bool accessTokenValid = await testAccessToken();

  initControllers();
  runApp(MyApp(accessTokenValid: accessTokenValid));
}

class MyApp extends StatelessWidget {
  final bool accessTokenValid;
  const MyApp({super.key, required this.accessTokenValid});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NavigationBinding(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      home: accessTokenValid
          ? AppShell()
          : LoginPageIndicator(),
    );
  }
}