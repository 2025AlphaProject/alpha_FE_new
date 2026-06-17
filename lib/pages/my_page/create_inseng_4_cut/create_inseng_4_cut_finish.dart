import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';
import 'components/four_cut_frame.dart';

class CreateInseng4CutFinish extends StatelessWidget {
  const CreateInseng4CutFinish({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyPageController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FourCutFrame(imagePaths: controller.selectedPaths),
      ),
    );
  }
}