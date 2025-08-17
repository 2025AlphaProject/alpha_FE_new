import 'package:get/get.dart';
import '../../../controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

import 'todayTrip_info_page.dart';
import 'todayTrip_photos_page.dart';

class TodayTripDetail extends StatelessWidget {
  const TodayTripDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Obx(
            () => Text(
              controller.tourName.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Get.back(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: const ColoredBox(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                tabs: [Tab(text: '여행 정보'), Tab(text: '업로드한 사진')],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: const [TodayTripInfoPage(), TodayTripPhotosPage()],
            ),
            Positioned(
              bottom: size.height * 0.03,
              right: size.width * 0.05,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFFFF6C57),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('사진 업로드'),
                            onTap: () {
                              // TODO: handle photo upload
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('촬영 후 업로드'),
                            onTap: () {
                              // TODO: handle capture and upload
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
