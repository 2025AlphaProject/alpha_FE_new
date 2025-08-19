import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';
import '../../../ai_add_page/ai_add_page.dart';

class AddPage1BottomButton extends StatelessWidget {
  const AddPage1BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 12),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Obx(() =>
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD3351E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
              onPressed: () {
                Get.to(() => AiAddPage());
              },
              child: Text( controller.isAiToggled.value
                  ? 'AI 추천 사용하기'
                  : "여행 장소 추가하기",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
        )
      ),
    );
  }
}