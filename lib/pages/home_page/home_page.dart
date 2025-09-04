import 'package:conever/controllers/home_page_controller.dart';
import 'package:conever/pages/home_page/components/todayTrip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
    controller.loadUserData();
  }


  final controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return VisibilityDetector(
      key: const Key('home-page'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1.0) {
          controller.loadTodayTour();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFF6C57),
        body: Column(
          children: [
            SizedBox(
                height: size.height * 0.4,
              child:Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05, right: size.width * 0.05),
                      child: SvgPicture.asset(
                        'assets/icons/logo_text.svg',
                        height: size.height * 0.025,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.08, left: size.width * 0.05),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/icons/airport.svg',
                              height: size.height * 0.2,
                            ),
                          ),
                          Text(
                            '${controller.userName.value} 님,',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '여행 준비 되셨나요?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
                clipBehavior: Clip.none,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Obx(()=>Skeletonizer(
                    enabled: controller.isTodayTourLoading.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(context),
                        const SizedBox(height: 16),
                        Expanded(
                          child: controller.todayTourNotFound.value
                          ? Center(child: Text('하단의 추가 버튼을 눌러 새 여행을 만들어 보세요!', style: TextStyle(color: Colors.grey),),)
                          : ListView.separated(
                            itemCount: controller.todayTours.length,
                            itemBuilder: (context, index) {
                              return TodayTripCard(
                                selectedIndex: index,
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(height: size.height * 0.02),
                          ),
                        ),
                      ],
                    ),
                  ),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    debugPrint('todayTourNotFound value: ${controller.todayTourNotFound.value}');
    return Obx(()=>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( controller.todayTourNotFound.value == true
              ? '오늘의 일정이 없어요'
              :'오늘의 여행은?',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_outlined),
        ],
      )
    );
  }
}