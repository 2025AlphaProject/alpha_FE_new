import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'components/bottom_navigation_bar/app_shell.dart';
import 'components/bottom_navigation_bar/navigation_binding.dart';
import 'init_controllers.dart';
import 'pages/login_page/login_page_indicator.dart';
import 'services/access_token/test_access_token.dart';


// 로거 사용을 위한 전역변수 선언
final logger = Logger();

// 네이버맵 sdk 초기화 함수
Future<void> initNaverMapSdk() async {
  debugPrint('initNaverMap: 네이버맵 sdk 초기화');
  await FlutterNaverMap().init(
      clientId: dotenv.env['NAVER_DYNAMIC_MAP'],

      // 인증 실패 시 실행될 콜백
      onAuthFailed: (ex) => switch (ex) {
        NQuotaExceededException(:final message) => logger.d('사용량 초과 (message: $message)'),
        NUnauthorizedClientException() ||
        NClientUnspecifiedException() ||
        NAnotherAuthFailedException() =>
            logger.d('인증 실패: $ex'),
      }
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  await dotenv.load();
  final bool accessTokenValid = await testAccessToken();
  final kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'];

  if (kakaoNativeAppKey == null || kakaoNativeAppKey.isEmpty) {
    runApp(const MaterialApp(
      color: Color(0xFFFFFFFF),
      home: SnackBar(content: Text(
          '카카오 sdk 오류',
          style: TextStyle(
              color: Colors.black
          )), backgroundColor: Colors.white,
      ),
    ));
    return;
  }

  if (!kIsWeb) {
    try {
      await initNaverMapSdk();
    } catch (e) {
      runApp(const MaterialApp(
        color: Color(0xFFFFFFFF),
        home: SnackBar(content: Text(
            '네이버 sdk 오류',
            style: TextStyle(
                color: Colors.black
            )), backgroundColor: Colors.white,
        ),
      ));
      return;
    }
  }

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