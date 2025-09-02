import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/bottom_navigation_bar/app_shell.dart';
import '../../../../../controllers/add_page_controller.dart';
import 'select_button.dart';

class AiAddPageBottomButton extends StatelessWidget {
  const AiAddPageBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(onPressed: () {
          final controller = Get.find<AddPageController>();
          Get.offAll(() => AppShell());
        },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                fixedSize: Size(width * 0.4, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            child: Text(
              '뒤로가기',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            )),
        SelectButton(),
      ],
    );
  }

}