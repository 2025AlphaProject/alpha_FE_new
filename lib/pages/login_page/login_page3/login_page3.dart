import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/bottom_navigation_bar/app_shell.dart';
import '../../../controllers/login_page_controller.dart';
import '../../../services/access_token/login_and_get_id_token.dart';

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
                  child: Image.asset(
                    'assets/icons/icon.png',
                    width: width * 0.8,
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