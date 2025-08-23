import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/controllers/plan_page_controller.dart';

import 'components/sort_by_button.dart';
import 'components/plan_card.dart';
import 'components/plan_indicator.dart';

class PlanPage1 extends GetView<PlanPageController>{
  const PlanPage1({super.key});
  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(width * 0.075),
          child: Column(
            children: [
              SizedBox(height: height * 0.064),
              Row( //상단 제목
                children: [
                  Icon(
                    Icons.airplanemode_active,
                    color:Color(0xFFD3351E),
                    size: width *0.08,
                  ),
                  SizedBox(width: width*0.034),
                  Text(
                    "나의 여행지",
                    style: TextStyle(
                      fontSize: width * 0.074,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.05),
              SortByButton(
                onOptionSelected: (value) {
                  controller.changeSortCriteria(value);
                },
              ),
              SizedBox(height: height * 0.03),
              SizedBox(
                height: height * 0.45,
                child: Obx(() => PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  controller: controller.pageController,
                  itemCount: controller.cards.length,
                  itemBuilder: (context, index) {
                    final item = controller.cards[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: PlanCard(
                        title: item['tour_name'] ?? '',
                        date: item['tour_date'] ?? '',
                        size_h: height * 0.21,
                        size_w: width * 0.34,
                        tour_id: item['id'],
                      ),
                    );
                  },
                ),
                ),
              ),
              SizedBox(height: height * 0.01,),
              // 페이지 인디케이터
              PlanIndicator(
                controller: controller.pageController,
                count: controller.cards.length,
                dotSize: width * 0.02,
                dotActiveWidth: width * 0.03,)
            ],
          ),
        )
    );
  }
}
