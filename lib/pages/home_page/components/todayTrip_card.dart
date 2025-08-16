import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/controllers/home_page_controller.dart';
import 'category_build_tag.dart';

class TodayTripCard extends StatelessWidget {
  const TodayTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // HomePageController 인스턴스 참조
    final c =
        Get.isRegistered<HomePageController>()
            ? Get.find<HomePageController>()
            : Get.put<HomePageController>(
              HomePageController(),
              permanent: true,
            );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCCCCC)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        // 컨트롤러 상태에서 표시용 데이터 계산
        final String title =
            c.tourName.value.isNotEmpty ? c.tourName.value : '여행 제목';
        final String dateText = c.tourDate.value ?? '';
        final String participantText = '${c.userCount.value}명';
        final String regionText = _regionFromPlaces(c.places);
        final int total = c.places.length;
        final int done = 0; // TODO: 업로드 완료 개수와 연동
        final double progress = total > 0 ? (done / total) : 0.0;
        final int percent = (progress * 100).round();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 태그 리스트(현재는 더미로 유지)
            Wrap(
              spacing: 8,
              children: [
                buildTag(context, '음식점'),
                buildTag(context, '스포츠'),
                buildTag(context, '숙박'),
              ],
            ),

            // 태그와 제목 사이 여백
            SizedBox(height: size.height * 0.012),

            // 여행 제목
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 제목과 메타정보 사이 여백
            SizedBox(height: size.height * 0.025),

            // 지역/날짜/인원 정보
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Color(0xFF9A9A9A),
                ),
                const SizedBox(width: 4),
                Text(
                  regionText,
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: const Color(0xFF707070),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color(0xFF9A9A9A),
                ),
                const SizedBox(width: 4),
                Text(
                  dateText,
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: const Color(0xFF707070),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.person, size: 16, color: Color(0xFF9A9A9A)),
                const SizedBox(width: 4),
                Text(
                  participantText,
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: const Color(0xFF707070),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // 메타정보와 진행도 사이 여백
            SizedBox(height: size.height * 0.02),

            // 진행도 표시
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$done / $total',
                  style: TextStyle(fontSize: size.width * 0.035),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  // 장소 목록에서 지역 텍스트 추출(주소/도로명 앞 2토큰 사용)
  String _regionFromPlaces(dynamic places) {
    try {
      if (places == null || places.length == 0) return '지역 정보 없음';
      final p = places[0];
      final addr = (p.address as String?) ?? '';
      final road = (p.roadAddress as String?) ?? '';
      final src = addr.isNotEmpty ? addr : road;
      if (src.isEmpty) return '지역 정보 없음';
      final parts = src.split(' ');
      return parts.length >= 2 ? '${parts[0]} ${parts[1]}' : src;
    } catch (_) {
      return '지역 정보 없음';
    }
  }
}
