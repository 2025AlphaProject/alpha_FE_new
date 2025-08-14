import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import 'inseng_4_cut_page/inseng_4_cut.dart';
import 'photo_album/photo_album.dart';
import 'switch/switch_context.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyPageController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 43.0),
        child: Column(
          children: [
            SwitchContext(),
            Obx(() => controller.selectPage.value == 0
                ? Expanded(child: Inseng4Cut()) : PhotoAlbum(),
            )
          ],
        ),
      ),
    );
  }

}