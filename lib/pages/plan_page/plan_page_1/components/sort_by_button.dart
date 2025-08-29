import 'package:conever/controllers/plan_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SortByButton extends StatelessWidget {
  final List<String> _options = ['날짜순','이름순'];

  SortByButton({super.key,});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.find<PlanPageController>();
    return Obx(
      () => Container(
        width: width * 0.3,
        height: height * 0.032,
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: DropdownButton<String>(
          value: controller.sortCriteria.value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: _options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.sortCriteria.value = value;
              controller.sortCards();
            }
          },
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
