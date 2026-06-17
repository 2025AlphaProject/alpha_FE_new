import 'package:conever/controllers/add_page_controller.dart';
import 'package:conever/pages/add_page/final_add_page/final_loading_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_add_page_controller.dart';

class UserAddSearchOverlay extends StatelessWidget {
  const UserAddSearchOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserAddPageController>();
    final addPageController = Get.find<AddPageController>();

    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    final height = MediaQuery.of(context).size.height;

    final overlayBg = Colors.white.withOpacity(0.88);
    final horizontal = width * 0.04;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용 높이만큼만 차지
          children: [
            // 상단 바
            Container(
              color: overlayBg, // 앱바 영역만 반투명
              padding: EdgeInsets.only(
                left: horizontal,
                right: horizontal,
                top: height * 0.015,
                bottom: height * 0.015,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.addedPlaces.clear();
                      controller.places.clear();
                      controller.searchController.clear();
                      Get.back();

                      },
                    child: const Icon(Icons.chevron_left,
                        color: Color(0xFFD3351E), size: 28),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      final List<Map<String, dynamic>> maps =
                      controller.addedPlaces.map((place) => place.toMap()).toList();
                      if (maps.isNotEmpty) {
                        debugPrint('maps: $maps');
                        addPageController.userSelectedTours.value = maps;
                        debugPrint('userSelectedTours: ${addPageController.userSelectedTours}');

                        controller.addedPlaces.clear();
                        controller.places.clear();
                        controller.searchController.clear();

                        Get.to(() => FinalLoadingPage());
                      }
                      else {
                        Get.snackbar('안내', '최소 한 개의 장소를 추가해야 합니다');
                      }
                    },
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Color(0xFFD3351E),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.01),

            // 검색창
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: height * 0.008,
              ),
              child: SizedBox(
                height: height * 0.055,
                child: TextField(
                  controller: controller.searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: '원하는 장소를 검색하세요',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.012,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        await controller.searchPlace(
                            controller.searchController.text);
                        if (controller.places.isNotEmpty) {
                          await controller.updateMarkers(context);
                        }
                        else{
                          Get.snackbar('안내', '검색 결과가 없습니다');
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (value) async {
                    FocusScope.of(context).unfocus();
                    await controller.searchPlace(value);
                    await controller.updateMarkers(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}