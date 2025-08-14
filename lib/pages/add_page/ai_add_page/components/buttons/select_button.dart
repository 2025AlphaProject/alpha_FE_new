import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';
import '../../../ask_add_page/ask_add_page.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    final width = MediaQuery.of(context).size.width;
    return Obx(() => controller.tourLength != 0
        ? ElevatedButton(onPressed: () {
          controller.saveSelectedAiTours();
          Get.to(() => AskAddPage());
          },
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFD3351E),
            fixedSize: Size(width * 0.45, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ), child: Obx(() => Text(
          '${controller.tourLength}개 장소 선택',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )
        )
    ) : ElevatedButton(onPressed: () {},
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[300],
            fixedSize: Size(width * 0.45, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
        child: Text("장소 선택",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )
    )
    );
  }
}