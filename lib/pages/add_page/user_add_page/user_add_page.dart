import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

import '../../../controllers/user_add_page_controller.dart';
import 'components/user_add_bottom_info_pill.dart';
import 'components/user_add_search_overlay.dart';


class UserAddPage extends StatelessWidget {
  const UserAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    final height = MediaQuery.of(context).size.height;

    final controller = Get.find<UserAddPageController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // 지도 풀스크린

          Positioned.fill(
            child: NaverMap(
              onMapReady: controller.setMapController,
              options: const NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: NLatLng(37.5665, 126.9780),
                  zoom: 12,
                ),
              ),
            ),
          ),

          // 상단 검색 오버레이

          const UserAddSearchOverlay(),

          // 하단 고정 팝업

          Positioned(  // <-- 여기서만 Positioned 처리
            bottom: height * 0.02,
            left: (MediaQuery.of(context).size.width - (width * 0.86)) / 2,
            child: const UserAddBottomInfoPill(),
          ),

        ],
      ),
    );
  }
}