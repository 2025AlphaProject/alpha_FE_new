import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import 'inseng_4_cut_page/inseng_4_cut.dart';
import 'photo_album/photo_album.dart';
import 'switch/switch_context.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final controller = Get.find<MyPageController>();
  @override
  void initState() {
    super.initState();
    controller.getUserTours();
    controller.getFourCutImages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 43.0),
        child: Column(
          children: [
            SwitchContext(),
            Expanded(
              child: Obx(() => controller.selectPage.value == 0
                ? Inseng4Cut() : PhotoAlbum()
              ),
            )
          ],
        ),
      ),
    );
  }
}