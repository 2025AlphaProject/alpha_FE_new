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

    // 더미 데이터 목록
    final items = List.generate(8, (i) => '장소 이름 ${i + 1}');

    return Column(
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

        // 카테고리 칩 영역 (가로 스크롤)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildTag(context, '전체', selected: true),
              SizedBox(width: size.width * 0.02),
              buildTag(context, '음식점'),
              SizedBox(width: size.width * 0.02),
              buildTag(context, '스포츠'),
              SizedBox(width: size.width * 0.02),
              buildTag(context, '숙박'),
            ],
          ),
        ),

        // 칩과 그리드 사이 여백
        SizedBox(height: size.height * 0.015),

        // 장소 카드 그리드
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridCount(size.width),
              crossAxisSpacing: size.width * 0.02,
              mainAxisSpacing: size.width * 0.02,
              childAspectRatio: 3 / 2.6,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return PlaceCard(
                title: items[index],
                onTap: () {
                  Get.to(
                    TodayTripPlaceDetailPage(),
                    arguments: {'title': items[index]},
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // 화면 너비에 따른 그리드 열 개수 결정

  int _gridCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    return 2;
  }
}
