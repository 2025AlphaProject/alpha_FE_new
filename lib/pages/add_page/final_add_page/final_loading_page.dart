import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_page_controller.dart';
import 'final_add_page.dart';

class FinalLoadingPage extends StatefulWidget {
  const FinalLoadingPage({super.key});

  @override
  State<FinalLoadingPage> createState() => _FinalLoadingPageState();
}

class _FinalLoadingPageState extends State<FinalLoadingPage> {
  final controller = Get.find<AddPageController>();
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    controller.postTours();
    await Future.delayed(const Duration(seconds: 1));
    Get.to(() => FinalAddPage());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              color: Color(0xFFD3351E),
              radius: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "여행 저장 중...",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: width * 0.076,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}