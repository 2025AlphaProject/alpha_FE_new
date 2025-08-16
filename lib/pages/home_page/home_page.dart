import 'package:conever/controllers/home_page_controller.dart';
// import 'package:conever/components/home/today_trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFF6C57), // 상단 배경 색상
      body: Column(
        children: [
          SizedBox(height: size.height * 0.4), // 로고 영역 (나중에 앱바 등으로 대체 가능)
          // 흰색 배경 본문
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(context),
                    const SizedBox(height: 16),
                    // const TodayTripCard(), // 커스텀 위젯
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '오늘의 여행은?',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }
}
