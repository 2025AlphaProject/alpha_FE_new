import 'package:flutter/material.dart';

import 'package:conever/pages/my_page/my_page.dart'; //페이지 연결 test용
import 'package:conever/pages/plan_page/plan_page_1/components/d_day.dart';


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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=> MyPage()
              ),
            );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Dday(date: date)
                  ],
                ),
                // Align( //디데이
                //     alignment: Alignment.topRight,
                //     child: Dday(date: date),
                // ),
                SizedBox(height: 40),
                Icon( //지도 아이콘
                  Icons.map_outlined,
                  size: 170,
                  color: Color(0xCCD3351E),
                ),
                SizedBox(height: 20),
                Text( // 여행 제목
                  title,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFFD3351E),
                  indent: 90,
                  endIndent: 90,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                    SizedBox(width: width * 0.013),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
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
