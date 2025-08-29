import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_page_controller.dart';
import 'components/button/add_page_1_bottom_button.dart';
import 'components/containers/select_date_container.dart';
import 'components/containers/select_name_container.dart';
import 'components/containers/select_region_container.dart';

class AddPage1 extends StatefulWidget {
  const AddPage1({super.key});

  @override
  State<AddPage1> createState() => _AddPage1State();
}

class _AddPage1State extends State<AddPage1> {
  final controller = Get.find<AddPageController>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 34, 10, 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 8,),
                  Text(
                    "새 여행 만들기",
                    style: TextStyle(
                      fontSize: width * 0.082,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Switch(
                    value: controller.isAiToggled.value,
                    onChanged: (bool newValue) {
                      controller.isAiToggled.value = newValue;
                    },
                    activeColor: Colors.green,
                  )),
                  const SizedBox(width: 4,),
                  Text(
                    'AI 추천 사용',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(width: 4,),
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 63,),
              Obx(() => controller.isAiToggled.value
                  ? SelectRegionContainer()
                  : SizedBox.shrink()
              ),
              Obx(() => controller.isAiToggled.value
                  ? SizedBox(height: 20,)
                  : SizedBox.shrink()
              ),
              SelectDateContainer(),
              SizedBox(height: 20,),
              SelectNameContainer(),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AddPage1BottomButton(),
    );
  }
}
