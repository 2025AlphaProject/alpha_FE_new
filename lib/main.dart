import 'dart:io';

import 'package:conever/controllers/my_page_controller.dart';
import 'package:conever/helper/tour/group_user_tour/regroup_user_tour.dart';
import 'package:conever/services/http/tour/get_one_tour.dart';
import 'package:conever/splash_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// 🔔 FCM / Firebase / Local Notifications
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// === 기존 앱 의존 ===
import 'components/bottom_navigation_bar/app_shell.dart';
import 'components/bottom_navigation_bar/navigation_binding.dart';
import 'init_controllers.dart';
import 'pages/login_page/login_page_indicator.dart';
import 'pages/my_page/photo_album/photo_display_loading_page.dart';
import 'services/access_token/save_access_and_refresh_token.dart';
import 'services/access_token/test_access_token.dart';
import 'services/http/user/fcm.dart';

// ================== 전역: 로거 / 로컬 알림 플러그인 / 채널 ==================
final logger = Logger();

final FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel kHighImportanceChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance',
  description: 'Heads-up banner notifications',
  importance: Importance.max,
  playSound: true,
);

// ================== 네이버맵 SDK 초기화 ==================
Future<void> initNaverMapSdk() async {
  debugPrint('initNaverMap: 네이버맵 sdk 초기화');
  await FlutterNaverMap().init(
    clientId: dotenv.env['NAVER_DYNAMIC_MAP'],
    onAuthFailed: (ex) => switch (ex) {
      NQuotaExceededException(:final message) => logger.d('사용량 초과 (message: $message)'),
      NUnauthorizedClientException() || NClientUnspecifiedException() || NAnotherAuthFailedException() =>
          logger.d('인증 실패: $ex'),
    },
  );
}

// ================== FCM 백그라운드 핸들러 (최상위 전역 필수) ==================
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // 필요시: 백그라운드 로깅/동기화
}

// ================== 로컬 알림 초기화 ==================
Future<void> _initLocalNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInit = DarwinInitializationSettings();
  const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

  await flnp.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (resp) {
      final payload = resp.payload;
      _handleDeepLinkPayload(payload);
    },
  );

  await flnp
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(kHighImportanceChannel);

  if (Platform.isAndroid) {
    await flnp
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}

// ================== FCM 권한 ==================
Future<void> _requestNotificationPermission() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true, badge: true, sound: true,
  );
  debugPrint('FCM permission: ${settings.authorizationStatus}');
}

// ================== 앱 시작 ==================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 화면 방향 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Firebase 초기화
  await Firebase.initializeApp();

  // FCM 백그라운드 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // .env 로드
  await dotenv.load();

  // 카카오 키 체크
  final kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'];
  if (kakaoNativeAppKey == null || kakaoNativeAppKey.isEmpty) {
    runApp(const MaterialApp(
      color: Color(0xFFFFFFFF),
      home: SnackBar(
        content: Text('카카오 sdk 오류', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
    ));
    return;
  }

  // 네이버맵 SDK
  if (!kIsWeb) {
    try {
      await initNaverMapSdk();
    } catch (e) {
      runApp(const MaterialApp(
        color: Color(0xFFFFFFFF),
        home: SnackBar(
          content: Text('네이버 sdk 오류', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
      ));
      return;
    }
  }

  // 로컬 알림 초기화
  await _initLocalNotifications();

  // iOS 포그라운드 표시 옵션
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, badge: true, sound: true,
  );

  // 알림 권한 요청
  await _requestNotificationPermission();

  // 액세스 토큰 검사
  final bool accessTokenValid = await testAccessToken();

  // 컨트롤러 초기화
  initControllers();

  // 개인정보 수집 동의여부 확인
  final bool privacyAgreement = await getPrivacyAgreement();

  debugPrint('accessTokenValid: $accessTokenValid');
  debugPrint('privacyAgreement: $privacyAgreement');

  // 앱 시작
  runApp(MyApp(accessTokenValid: accessTokenValid, privacyAgreement: privacyAgreement));
}

// ================== 앱 위젯 ==================
class MyApp extends StatefulWidget {
  final bool accessTokenValid;
  final bool privacyAgreement;
  const MyApp({super.key, required this.accessTokenValid, required this.privacyAgreement});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _initMessaging(); // FCM 리스너/초기 메시지 처리
  }

  Future<void> _initMessaging() async {
    // 디바이스 토큰
    final token = await FirebaseMessaging.instance.getToken();
    await postFCMToken(token);

    // (1) 포그라운드 수신 → 로컬 알림(헤드업)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title = message.notification?.title ?? message.data['title']?.toString() ?? '알림';
      final body  = message.notification?.body  ?? message.data['body']?.toString()  ?? '';

      final snapshotId = message.data['snapshot_id']?.toString().trim();
      String? deeplink = message.data['deeplink']?.toString().trim();

      if ((snapshotId != null && snapshotId.isNotEmpty) &&
          (deeplink == null || deeplink.isEmpty)) {
        deeplink = 'conever://snapshot?id=$snapshotId';
      }

      await flnp.show(
        message.hashCode,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance',
            channelDescription: 'Heads-up banner notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: deeplink, // 배너 탭 시 _handleDeepLinkPayload로 감
      );
    });

    // (2) 백그라운드에서 알림 탭 → 앱 열림
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final snapId  = message.data['snapshot_id']?.toString().trim();
      final rawDeep = message.data['deeplink']?.toString().trim();

      if (snapId?.isNotEmpty == true) {
        _navigateToSnapshotId(snapId!);
      } else if (rawDeep?.isNotEmpty == true) {
        _handleDeepLinkPayload(rawDeep);
      }
    });

    // (3) 종료(콜드 스타트)에서 알림 탭 → 앱 시작
    final initialMsg = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMsg != null) {
      final snapId  = initialMsg.data['snapshot_id']?.toString().trim();
      final rawDeep = initialMsg.data['deeplink']?.toString().trim();

      // 첫 프레임 이후 라우팅 (Navigator 준비 시점 보장)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (snapId?.isNotEmpty == true) {
          _navigateToSnapshotId(snapId!);
        } else if (rawDeep?.isNotEmpty == true) {
          _handleDeepLinkPayload(rawDeep);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NavigationBinding(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      home: SplashRouter(accessTokenValid: widget.accessTokenValid, privacyAgreement: widget.privacyAgreement)
    );
  }
}

// ================== 공통 유틸: 딥링크 → Get.to() 라우팅 ==================

// 로컬 알림 배너 탭 / 백그라운드 탭 / 콜드스타트에서 공통 사용
void _handleDeepLinkPayload(String? deepLink) {
  if (deepLink == null || deepLink.trim().isEmpty) return;

  // 안전 파싱(이중 인코딩 방어)
  String decoded = deepLink.trim();
  try {
    decoded = Uri.decodeFull(decoded);
    decoded = Uri.decodeFull(decoded);
  } catch (_) {}

  final uri = Uri.tryParse(decoded);
  if (uri == null) return;

  final id = _extractSnapshotId(uri);
  if (id != null) {
    _navigateToSnapshotId(id);
  } else if (uri.scheme == 'conever' && uri.host == 'snapshot') {
    _navigateToSnapshotEmpty();
  }
}

// conever://snapshot?id=123  또는 conever://snapshot/123  지원
String? _extractSnapshotId(Uri uri) {
  if (uri.scheme != 'conever' || uri.host != 'snapshot') return null;
  // 쿼리(id) 우선
  final q = uri.queryParameters['id'];
  if (q != null && q.isNotEmpty) return q;
  // 하위호환: path 세그먼트
  if (uri.pathSegments.isNotEmpty && uri.pathSegments.first.isNotEmpty) {
    return uri.pathSegments.first;
  }
  return null;
}

// ===== 실제 이동부 (Get.to만 사용) =====

// 스냅샷 ID로 진입: AppShell로 넘기고 내부에서 처리하도록 설계
Future<void> _navigateToSnapshotId(String id) async {
  final controller = Get.find<MyPageController>();
  final rawData = await getOneTour(id);

  controller.selectedTourId.value = rawData.first['id'];
  controller.selectedTourArea.value = rawData.first['area_info'];
  controller.selectedTourName.value = rawData.first['tour_name'];
  controller.selectedTourDate.value = rawData.first['tour_date'];
  Get.to(() => PhotoDisplayLoadingPage());
}

// ID 없이 스냅샷 진입
void _navigateToSnapshotEmpty() {
  Get.to(() => const AppShell(), arguments: {'route': 'snapshot'});
}

// ===== (선택) 로컬 알림 강제 테스트 =====
// 필요하면 어디서든 호출해서 동작 확인 가능
Future<void> showLocalTest() async {
  await flnp.show(
    9999,
    '로컬 테스트',
    '탭해서 snapshot 777 열기',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance',
        channelDescription: 'Heads-up banner notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    ),
    payload: 'conever://snapshot?id=777',
  );
}