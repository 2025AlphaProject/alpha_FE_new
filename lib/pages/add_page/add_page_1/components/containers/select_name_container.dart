import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';

class SelectNameContainer extends StatelessWidget {
  const SelectNameContainer({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    return ExpandableNotifier(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 80,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(0, 3)
              )
            ]
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20), // BoxDecoration의 Radius와 맞출 것
          clipBehavior: Clip.antiAlias,
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              hasIcon: false,
              tapBodyToExpand: true,
              tapHeaderToExpand: true,
              tapBodyToCollapse: true,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '여행 제목',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        size: 30,
                      ),
                    ],
                  ),
                  Obx(() => controller.selectedName.value.isNotEmpty
                      ? Text(
                    controller.selectedName.value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey
                    ),
                  ) : SizedBox.shrink()
                  )
                ],
              ),
            ),
            expanded: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: TextField(
                      maxLength: 10,
                      controller: controller.textController,
                      onChanged: (value) {
                        controller.selectedName.value = value;
                      },
                      decoration: InputDecoration(
                        hintText: "10자 내로 입력하세요",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            collapsed: SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}