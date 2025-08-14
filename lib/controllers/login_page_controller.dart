import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final PageController pageController = PageController();
  RxString kakaoNativeAppKey = ''.obs;
  RxString kakaoJavaScriptAppKey = ''.obs;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKakaoKeys();
  }

  Future<void> fetchKakaoKeys() async {
    kakaoNativeAppKey.value = dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? "";
    kakaoJavaScriptAppKey.value = dotenv.env['KAKAO_JAVA_SCRIPT_APP_KEY'] ?? "";
  }

  void changePage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      currentPage.value++;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}