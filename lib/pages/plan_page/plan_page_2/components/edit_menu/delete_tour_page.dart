import 'package:conever/controllers/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/components/bottom_navigation_bar/app_shell.dart';

class DeleteTourPage extends StatelessWidget {
  const DeleteTourPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.15,),
            Image.asset(
              'assets/icons/delete_tour_page_icon.png',
              width: width*0.5,
            ),
            SizedBox(height: height*0.05,),
            Text(
              '여행이 삭제되었어요',
              style: TextStyle(
                  fontSize: width *0.06,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF000000)
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width *0.06, vertical: height *0.01),
          child: SizedBox(
            height:height *0.06,
            child: ElevatedButton(onPressed: () {
              final controller = Get.find<NavigationController>();
              controller.tabIndex.value = 0;  // 홈 페이지 이동
              Get.offAll(() => AppShell());
            },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xCCD3351E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
                child: Text(
                  "확인",
                  style: TextStyle(
                    fontSize: width *0.046,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
      ),
    );
  }

}