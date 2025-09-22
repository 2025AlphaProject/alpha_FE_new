import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/login_page_controller.dart';
import 'login_page1/login_page1.dart';
import 'login_page2/login_page2.dart';
import 'login_page3/login_page3.dart';

class LoginPageIndicator extends StatelessWidget {

  const LoginPageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginPageController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.9,
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.changePage,
              children: [
                const LoginPage1(),
                const LoginPage2(),
                const LoginPage3(),
              ],
            ),
          ),
          Expanded(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: Color(0xFFDBDBDB),
                  activeDotColor: Color(0xFFD3351E)
                ),

              )
          )
        ],
      ),
    );
  }
}