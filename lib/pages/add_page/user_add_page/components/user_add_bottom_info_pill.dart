import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_add_page_controller.dart';

class UserAddBottomInfoPill extends StatelessWidget {
  const UserAddBottomInfoPill({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserAddPageController>();

    // 반응형 크기 계산

    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.places.isEmpty) return const SizedBox.shrink();

      // 하단 중앙 고정 팝업

      return Container(
        width: width * 0.86,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.045,
          vertical: height * 0.014,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 결과 개수 문구

            Expanded(
              child: Text(
                '${controller.places.length}개의 장소를 찾았습니다.',
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // 목록보기 버튼

            GestureDetector(
              onTap: () => controller.openListSheet(context),
              child: Text(
                '목록보기',
                style: TextStyle(
                  fontSize: width * 0.038,
                  color: const Color(0xFFD3351E),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}