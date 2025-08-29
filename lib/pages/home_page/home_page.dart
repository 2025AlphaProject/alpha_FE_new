import 'package:conever/controllers/home_page_controller.dart';
import 'package:conever/pages/home_page/components/todayTrip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'todayTrip_detail_page/todayTrip_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }


  final controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return VisibilityDetector(
      key: const Key('home-page'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0) {
          controller.loadTodayTour();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFF6C57),
        body: Column(
          children: [
            SizedBox(height: size.height * 0.4),
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
                      const TodayTripCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        controller.todayTourNotFound.value
        ? (){}
        : Get.to(TodayTripDetail())
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( controller.todayTourNotFound.value
              ? '오늘의 일정이 없어요'
            :'오늘의 여행은?',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}