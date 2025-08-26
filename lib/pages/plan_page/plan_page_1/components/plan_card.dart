import 'package:conever/pages/plan_page/plan_page_2/plan_page_2_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/pages/plan_page/plan_page_1/components/d_day.dart';
import 'package:conever/controllers/plan_page_controller.dart';


class PlanCard extends StatelessWidget {
  final String title;
  final String date;
  final double size_h;
  final double size_w;
  final int tour_id;
  const PlanCard({
    Key? key,
    required this.title,
    required this.date,
    required this.size_h,
    required this.size_w,
    required this.tour_id
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size_h,
      width: size_w,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: const Color(0xFFFFFFFF), // 불투명 빨강 (#D3351E)
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFFD3351E),
            width: 1.0
          ),
        ),
        child: InkWell(
          onTap: () async {
            final controller = Get.find<PlanPageController>();
            await controller.tourCourse(tour_id);
            Get.to(() => PlanPage2(tour_id: tour_id)); //계획페이지 2로 넘어가는 부분
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              width * 0.05,
              height * 0.02,
              width * 0.05,
              height * 0.05,
            ),
            child: Column( //카드 안의 내용 표시 부분
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row( //디데이
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Dday(date: date)
                  ],
                ),
                // SizedBox(height: height *0.0),
                // Icon( //지도 아이콘
                //   Icons.map_outlined,
                //   size: width *0.39,
                //   color: Color(0xCCD3351E),
                // ),
                Image.asset(
                  'assets/icons/plan_card_icon.png',
                  width: width*0.6,
                ),
                // SizedBox(height: height *0.011),
                Text( // 여행 제목
                  title,
                  style: TextStyle(fontSize: width *0.048, fontWeight: FontWeight.w900),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFD3351E),
                  indent: 60,
                  endIndent: 60,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, size: width* 0.045, color: Colors.grey),
                    SizedBox(width: width * 0.013),
                    Text(
                      date,
                      style: TextStyle(fontSize: width * 0.024, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
