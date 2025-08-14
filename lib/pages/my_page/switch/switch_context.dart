import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';

class SwitchContext extends StatefulWidget {
  const SwitchContext({super.key});

  @override
  State<SwitchContext> createState() => _SwitchContextState();
}

class _SwitchContextState extends State<SwitchContext> {
  final controller = Get.find<MyPageController>();

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<int>(
      groupValue: controller.selectPage.value,
      backgroundColor: const Color(0xFFF0F0F0),
      thumbColor: Colors.white,
      padding: const EdgeInsets.all(4),
      children: const {
        0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Text('인생네컷', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
        ),
        1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Text('여행 앨범', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
        ),
      },
      onValueChanged: (v) => setState(() => controller.selectPage.value = v ?? 0),
    );
  }
}