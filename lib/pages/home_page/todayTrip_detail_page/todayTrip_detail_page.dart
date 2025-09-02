import 'package:get/get.dart';
import '../../../controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

import '../components/image_upload_FAB.dart';
import 'todayTrip_info_page.dart';
import 'todayTrip_photos_page.dart';

class TodayTripDetail extends StatefulWidget {
  final int selectedIndex;

  const TodayTripDetail({super.key, required this.selectedIndex});

  @override
  State<TodayTripDetail> createState() => _TodayTripDetailState();
}

class _TodayTripDetailState extends State<TodayTripDetail> {
  final controller = Get.find<HomePageController>();

  @override
  void initState() {
    super.initState();
    // 화면 진입 시점에서만 실행 → 빌드 중에는 실행 안 됨
    final tourId = controller.todayTours[widget.selectedIndex].tourId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tourId = controller.todayTours[widget.selectedIndex].tourId;
      controller.loadTodayCourses(tourId);
      controller.loadTourImages(tourId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Obx(
                () => Text(
              controller.todayTours[widget.selectedIndex].tourName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Get.back(),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: '여행 정보'),
                  Tab(text: '업로드한 사진'),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                TodayTripInfoPage(selectedIndex: widget.selectedIndex),
                TodayTripPhotosPage(selectedIndex: widget.selectedIndex),
              ],
            ),
            Positioned(
              bottom: size.height * 0.03,
              right: size.width * 0.05,
              child: buildImageUploadFAB(context, widget.selectedIndex),
            )
          ],
        ),
      ),
    );
  }
}
