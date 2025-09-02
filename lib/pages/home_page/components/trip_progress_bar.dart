// 진행도 UI 컴포넌트
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/controllers/home_page_controller.dart';

class TripProgressBar extends StatelessWidget {
  final int selectedIndex;
  const TripProgressBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // HomePageController 인스턴스 참조
    final c = Get.isRegistered<HomePageController>()
        ? Get.find<HomePageController>()
        : Get.put<HomePageController>(HomePageController(), permanent: true);
    return Obx(() {
      double progress = c.todayTours[selectedIndex].placeCnt > 0 ? (c.todayTours[selectedIndex].imageCnt / c.todayTours[selectedIndex].imageCnt) : 0.0;
      // 진행 값 보정
      double p = progress.isNaN || !progress.isFinite ? 0.0 : progress;
      if (p < 0) p = 0;
      if (p > 1) p = 1;
      final int percent = (p * 100).round();
      return LayoutBuilder(
        builder: (context, constraints) {
          final double barWidth = constraints.maxWidth;
          // 크기 계산
          final double barHeight = size.height * 0.012;
          final double headerHeight = size.height * 0.04; // 아이콘/진행도 텍스트 영역
          final double bubbleHeight = size.height * 0.04; // 퍼센트 말풍선 영역
          final double bubbleWidth = size.width * 0.16;
          final double handleDiameter = barHeight * 1.8;
          final double barTop = headerHeight + bubbleHeight;
          // 위치 계산
          final double fillWidth = barWidth * p;
          double handleLeft = fillWidth - (handleDiameter / 2);
          if (handleLeft < 0) handleLeft = 0;
          if (handleLeft > barWidth - handleDiameter) {
            handleLeft = barWidth - handleDiameter;
          }
          double bubbleLeft = fillWidth - (bubbleWidth / 2);
          if (bubbleLeft < 0) bubbleLeft = 0;
          if (bubbleLeft > barWidth - bubbleWidth) {
            bubbleLeft = barWidth - bubbleWidth;
          }
          // 전체 높이: 헤더(아이콘/텍스트) + 말풍선 + 핸들 높이
          final double totalHeight = barTop + handleDiameter;
          return SizedBox(
            height: totalHeight,
            width: barWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 상단 헤더: 좌측 아이콘
                Positioned(
                  left: 0,
                  top: headerHeight,
                  child: SizedBox(
                    width: size.width * 0.08,
                    height: size.width * 0.08,
                    child: Image.asset(
                      'assets/icons/image_icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // 상단 헤더: 우측 진행도 텍스트
                Positioned(
                  right: 0,
                  top: headerHeight,
                  child: Text(
                    '${c.todayTours[selectedIndex].imageCnt} / ${c.todayTours[selectedIndex].placeCnt}',
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFB0B0B0),
                    ),
                  ),
                ),
                // 바탕 트랙
                Positioned(
                  left: 0,
                  right: 0,
                  top: barTop,
                  height: barHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(barHeight / 2),
                    ),
                  ),
                ),
                // 채워진 트랙
                Positioned(
                  left: 0,
                  top: barTop,
                  height: barHeight,
                  width: fillWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(barHeight / 2),
                    ),
                  ),
                ),
                // 동그란 핸들
                Positioned(
                  left: handleLeft,
                  top: barTop - (handleDiameter - barHeight) / 2,
                  width: handleDiameter,
                  height: handleDiameter,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.redAccent,
                        width: barHeight * 0.3,
                      ),
                    ),
                  ),
                ),
                // 상단 퍼센트 말풍선
                Positioned(
                  left: bubbleLeft,
                  top:
                      headerHeight +
                      (bubbleHeight - (size.height * 0.04)) / 2 -
                      size.height * 0.006,
                  width: bubbleWidth,
                  height: bubbleHeight,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                    ),
                    child: Text(
                      '$percent%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
