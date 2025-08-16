import 'package:flutter/material.dart';

import 'todayTrip_info_page.dart';
import 'todayTrip_photos_page.dart';

class TodayTripDetail extends StatelessWidget {
  const TodayTripDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('태그니의 아산 여행'),
          leading: const BackButton(),
          bottom: const TabBar(
            tabs: [Tab(text: '여행 정보'), Tab(text: '업로드한 사진')],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: TabBarView(
                children: const [TodayTripInfoPage(), TodayTripPhotosPage()],
              ),
            ),
            Positioned(
              bottom: size.height * 0.03,
              right: size.width * 0.05,
              child: FloatingActionButton(
                onPressed: () {
                  // TODO: handle add action
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
