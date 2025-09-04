import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_page_controller.dart';
import 'ai_add_page.dart';

class AiLoadingPage extends StatefulWidget {
  const AiLoadingPage({super.key});

  @override
  State<AiLoadingPage> createState() => _AiLoadingPageState();
}

class _AiLoadingPageState extends State<AiLoadingPage> {
  final controller = Get.find<AddPageController>();
  @override
  void initState() {
    super.initState();
    controller.fetchAITour();
    ever(controller.isLoading, (bool isLoading) {
      if (!isLoading) {
        Get.off(() => AiAddPage());
      }
    });
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
                "AI 여행 생성 중...",
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