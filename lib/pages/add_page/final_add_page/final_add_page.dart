import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/bottom_navigation_bar/app_shell.dart';
import '../../../controllers/bottom_navigation_controller.dart';

class FinalAddPage extends StatelessWidget {
  const FinalAddPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/icons/final_add_page_icon.png',
              width: 200,
            ),
            Text(
                '여행이 추가됐어요',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(onPressed: () {
              final controller = Get.find<NavigationController>();
              controller.tabIndex.value = 0;  // 홈 페이지 이동
              Get.offAll(() => AppShell());
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD3351E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                child: Text(
                    "확인",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
      ),
    );
  }

}