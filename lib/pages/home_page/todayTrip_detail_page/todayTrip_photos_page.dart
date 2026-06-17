import 'package:conever/pages/home_page/todayTrip_detail_page/todayTrip_photo_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../../controllers/home_page_controller.dart';

class TodayTripPhotosPage extends StatelessWidget {
  final int selectedIndex;
  const TodayTripPhotosPage({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final c =
    Get.isRegistered<HomePageController>()
        ? Get.find<HomePageController>()
        : Get.put<HomePageController>(
      HomePageController(),
      permanent: true,
    );

    final List<Map<String, dynamic>> photos = c.tourImages;

    return Obx(() {
      if (c.isTourImageLoading.value) {
        return Container(
          color: Color(0xFFF4F4F4),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (photos.isEmpty) {
        return Container(
          color: Color(0xFFF4F4F4),
          child: Center(
            child: Text(
              '업로드한 사진이 없습니다',
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }

      // 사진 그리드 표시
      return Container(
        color: Color(0xFFF4F4F4),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //_gridCount(size.width),
            // crossAxisSpacing: size.width * 0.02,
            // mainAxisSpacing: size.width * 0.02,
            childAspectRatio: 1,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.dialog(
                  todayTripPhotoDetailPage(
                    selectedIndex: selectedIndex,
                    imageUrl: photos[index]['image'],
                    imageId: photos[index]['id'],
                  ),
                  barrierDismissible: true,
                );
              },
              child: Image.network(
                photos[index]['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text(
                    '이미지 로딩 오류',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });

  }

  // 화면 너비에 따른 그리드 열 개수 결정

  int _gridCount(double width) {
    if (width >= 1200) return 6;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }
}
