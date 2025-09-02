import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/controllers/home_page_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../components/trip_progress_bar.dart';
import '../todayTrip_detail_page/todayTrip_detail_page.dart';

class TodayTripCard extends StatelessWidget {
  final int selectedIndex;
  const TodayTripCard({super.key, required this.selectedIndex});

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


    return GestureDetector(
      onTap: (){
        Get.to(
          () => TodayTripDetail(selectedIndex: selectedIndex),
        );
      },
      child: Container(
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
        child: Obx((){
          return c.todayTourNotFound.value == true
              ? SizedBox(height: size.height * 0.2,child: Center(child: Text('새 여행을 추가해 보세요!', style: TextStyle(color: const Color(0xFF707070)),),))
              :Skeletonizer(
            enabled: c.isLoading.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Wrap(
                  spacing: 8,
                  children:
                  c.todayTours[selectedIndex].categoryList
                      .skip(1)
                      .map((cat) => TagChip(cat, context))
                      .toList(),
                ),

                // 태그와 제목 사이 여백
                SizedBox(height: size.height * 0.012),

                // 여행 제목
                Text(
                  c.todayTours[selectedIndex].tourName.isNotEmpty ? c.todayTours[selectedIndex].tourName : '여행 제목',
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
                      c.todayTours[selectedIndex].tourAreaInfo[0],
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
                      c.todayTours[selectedIndex].tourDate ?? '',
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
                      '${c.todayTours[selectedIndex].peopleCnt}명',
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        color: const Color(0xFF707070),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // 메타정보와 진행도 사이 여백
                SizedBox(height: size.height * 0.035),

                // 진행도 표시
                TripProgressBar(selectedIndex: selectedIndex),
              ],
            ),


          );
        })
      ),
    );
  }

  // TagChip: 태그 표시용 칩
  Widget TagChip(String label, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.032,
        vertical: size.height * 0.006,
      ),
      margin: EdgeInsets.only(bottom: size.height * 0.003),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFEF3F26),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size.width * 0.032,
        ),
      ),
    );
  }

  // // 장소 목록에서 지역 텍스트 추출(주소/도로명 앞 2토큰 사용)
  // String _regionFromPlaces(dynamic places) {
  //   try {
  //     if (places == null || places.length == 0) return '지역 정보 없음';
  //     final p = places[0];
  //     final addr = (p.address as String?) ?? '';
  //     final road = (p.roadAddress as String?) ?? '';
  //     final src = addr.isNotEmpty ? addr : road;
  //     if (src.isEmpty) return '지역 정보 없음';
  //     final parts = src.split(' ');
  //     return parts.length >= 2 ? '${parts[0]} ${parts[1]}' : src;
  //   } catch (_) {
  //     return '지역 정보 없음';
  //   }
  // }
}
