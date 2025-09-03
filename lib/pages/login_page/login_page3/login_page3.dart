import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../components/bottom_navigation_bar/app_shell.dart';
import '../../../controllers/login_page_controller.dart';
import '../../../main.dart';
import '../../../services/access_token/login_and_get_id_token.dart';
import '../../../services/http/user/fcm.dart';
import '../tester_login/tester_login.dart';

class LoginPage3 extends StatelessWidget {
  const LoginPage3({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginPageController>();
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) {
      width = 410;
    }
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.064),
            child: Column(
              children: [
                SizedBox(height: height * 0.0394),
                // Centered logo
                Center(
                  child: GestureDetector(
                    onTap: () => TesterLogin().testLoginTap(context),
                    child: Image.asset(
                      'assets/icons/icon.png',
                      width: width * 0.8,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.0591),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '지금,\n',
                        style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: '커네버',
                        style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '에서\n',
                        style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: '시작',
                        style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '하기',
                        style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.1),
                Padding(
                  padding: EdgeInsets.fromLTRB(width*0.0533, 0, width*0.0533, height*0.0394),
                  child: GestureDetector(
                    onTap: () async {
                      final success = await KakaoLoginService.login(
                          nativeKey: controller.kakaoNativeAppKey.value,
                          jsKey: controller.kakaoJavaScriptAppKey.value
                      );
                        if (success) {
                          _initMessaging();
                          Get.offAll(() => AppShell());
                        } else {
                          Get.snackbar('오류 발생', '오류가 발생했습니다!');
                        }
                    },
                    child: Image.asset(
                      'assets/buttons/kakao_login_button.png',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
void _navigateToSnapshotId(String id) {
  // AppShell에서 Get.arguments를 읽어 탭/상세 이동 처리
  // 예: if (args?['route']=='snapshot') { final id=args?['id']; ... }
  Get.to(() => const AppShell(), arguments: {'route': 'snapshot', 'id': id});
}

// ID 없이 스냅샷 진입
void _navigateToSnapshotEmpty() {
  Get.to(() => const AppShell(), arguments: {'route': 'snapshot'});
}
