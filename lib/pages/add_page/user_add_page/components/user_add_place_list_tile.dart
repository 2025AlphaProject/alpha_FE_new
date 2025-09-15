import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_add_page_controller.dart';

class UserAddPlaceListTile extends StatelessWidget {
  final Map<String, dynamic> doc;

  const UserAddPlaceListTile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserAddPageController>();

    // 반응형 크기 계산

    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    final titleSize = width * 0.038;
    final subSize = width * 0.034;
    final iconSize = width * 0.07;
    final kakaoId = doc['id'].toString();

    return Obx(() {
      final added = controller.isAdded(kakaoId);
      final isSelected = controller.selectedPlace.value?['id'] == kakaoId;

      return InkWell(
        onTap: () {
          // 1. BottomSheet 닫기
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }

          // 2. 선택한 장소 업데이트
          controller.selectPlace(doc);

          // 3. 지도 카메라 이동 (scroll + zoom)
          final lat = double.tryParse(doc['y'] ?? '');
          final lng = double.tryParse(doc['x'] ?? '');
          if (lat != null && lng != null) {
            try {
              controller.mapController.updateCamera(
                NCameraUpdate.scrollAndZoomTo(
                  target: NLatLng(lat, lng),
                  zoom: width > 500 ? 14 : 15, // 웹은 살짝 덜 확대
                ),
              );
            } catch (e) {
              debugPrint("카메라 이동 실패: $e");
            }
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey.shade200 : Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 텍스트 묶음
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 장소명
                    Text(
                      doc['place_name'] ?? '',
                      style: TextStyle(
                        fontSize: titleSize,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: subSize * 0.3),
                    // 도로명 주소
                    Text(
                      doc['road_address_name'] ?? '',
                      style: TextStyle(
                        fontSize: subSize,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: width * 0.02),
              // 추가 버튼 또는 체크
              GestureDetector(
                onTap: () {
                  if (added) {
                    controller.addedPlaces.removeWhere((p) => p.sourceId.toString() == kakaoId);
                  } else {
                    controller.addPlaceFromDoc(doc);
                  }
                },
                child: Container(
                  width: iconSize * 1.15,
                  height: iconSize * 1.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD3351E),
                      width: 1.5,
                    ),
                    color: added ? const Color(0xFFD3351E) : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    added ? Icons.check : Icons.add,
                    size: iconSize,
                    color: added ? Colors.white : const Color(0xFFD3351E),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}