// ================== 라우팅 조건 분기 위젯 ==================
import 'package:conever/pages/login_page/login_page_indicator.dart';
import 'package:conever/pages/login_page/privacy_agree_page/privacy_agreement_page.dart';
import 'package:conever/services/access_token/save_access_and_refresh_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/bottom_navigation_bar/app_shell.dart';

class SplashRouter extends StatefulWidget {
  final bool accessTokenValid;
  final bool privacyAgreement;

  const SplashRouter({
    super.key,
    required this.accessTokenValid,
    required this.privacyAgreement,
  });

  @override
  State<SplashRouter> createState() => _SplashRouterState();
}

class _SplashRouterState extends State<SplashRouter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _decideRoute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _decideRoute() async {
    final accessToken = widget.accessTokenValid ? await getAccessToken() : null;
    final privacyAgreement = widget.privacyAgreement;

    if (accessToken == null) {
      Get.offAll(() => const LoginPageIndicator());
      return;
    }

    if (!privacyAgreement) {
      final result = await Get.to(() => const PrivacyAgreementPage());
      if (result == true) {
        await savePrivacyAgreement(true);
        Get.offAll(() => const AppShell());
      }
      return;
    }

    Get.offAll(() => const AppShell());
  }
}
