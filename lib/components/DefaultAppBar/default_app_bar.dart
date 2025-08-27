import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import '../bottom_navigation_bar/app_shell.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyPageController>();
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black)
      ),
      actions: [
        IconButton(onPressed: () {
          Get.dialog(
              AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  '여행 삭제',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                content: Text('여행을 삭제하시겠습니까?'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ), onPressed: () => Get.back(), child: Text('취소')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD3351E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ), onPressed: () async {
                        controller.deleteAllTour();
                        Get.back();
                        Get.back();
                  }, child: Text('확인')),
                ],
              )
          );
        }, icon: const Icon(
            Icons.delete_forever_outlined
        )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}