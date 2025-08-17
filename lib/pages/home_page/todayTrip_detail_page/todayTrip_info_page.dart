import 'package:conever/controllers/home_page_controller.dart';
import 'package:conever/pages/home_page/todayTrip_detail_page/todayTrip_place_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/category_build_tag.dart';
import '../components/todayTrip_place_card.dart';

class TodayTripInfoPage extends StatelessWidget {
  const TodayTripInfoPage({super.key});

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

    return Container(
      color: Color(0xFFF4F4F4),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 섹션 제목
            Text(
              '여행 장소 정보',
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w700,
              ),
            ),

            // 제목과 칩 사이 여백
            SizedBox(height: size.height * 0.015),

            // 섹션 박스(칩 + 그리드)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 카테고리 칩 영역 (가로 스크롤)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() {
                        final cats = c.categories;
                        return Row(
                          children: [
                            for (int i = 0; i < cats.length; i++) ...[
                              buildTag(
                                context,
                                _chipLabel(cats[i]),
                                selected: c.selectedCategory.value == cats[i],
                                onSelected: (_) => c.setCategory(cats[i]),
                              ),
                              if (i != cats.length - 1)
                                SizedBox(width: size.width * 0.02),
                            ],
                          ],
                        );
                      }),
                    ),

                    // 칩과 그리드 사이 여백
                    SizedBox(height: size.height * 0.015),

                    // 그리드
                    Expanded(
                      child: Obx(() {
                        if (c.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (c.errorMessage.value.isNotEmpty) {
                          return Center(child: Text(c.errorMessage.value));
                        }
                        final data = c.filteredPlaces;
                        if (data.isEmpty) {
                          return const Center(child: Text('해당 카테고리 장소가 없습니다'));
                        }
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _gridCount(size.width),
                                crossAxisSpacing: size.width * 0.04,
                                mainAxisSpacing: size.width * 0.08,
                                childAspectRatio: 1,
                              ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final p = data[index];
                            return PlaceCard(
                              title: p.name,
                              onTap: () {
                                Get.to(
                                  () => const TodayTripPlaceDetailPage(),
                                  arguments: {
                                    'title': p.name,
                                    'category': p.categoryName,
                                    'region': _regionFromPlace(p),
                                    'jibun': p.address,
                                    'road': p.roadAddress,
                                    'imageUrl': p.imageUrl,
                                    'id': p.id,
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 화면 너비에 따른 그리드 열 개수 결정

  int _gridCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    return 2;
  }

  String _regionFromPlace(TourPlace p) {
    final src = p.address.isNotEmpty ? p.address : p.roadAddress;
    if (src.isEmpty) return '지역 정보 없음';
    final parts = src.split(' ');
    return parts.length >= 2 ? '${parts[0]} ${parts[1]}' : src;
  }

  String _chipLabel(String category) {
    if (category == '전체') {
      return '전체';
    }
    return '$category';
  }
}
