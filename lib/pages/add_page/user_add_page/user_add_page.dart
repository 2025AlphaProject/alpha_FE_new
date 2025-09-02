import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

import '../../../controllers/search_place_page_controller.dart';

class UserAddPage extends StatelessWidget {


  const UserAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    final height = MediaQuery.of(context).size.height;

    final controller = Get.find<SearchPlaceController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),

      // 전체 레이아웃: 검색창, 지도, 검색결과 리스트, 선택 버튼 순서로 배치
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),

        // 검색창: 사용자가 장소를 입력하고 검색할 수 있음
        title: TextField(
          controller: controller.searchController,
          style: const TextStyle(fontSize: 16.5),
          decoration: InputDecoration(
            hintText: '서울 내의 장소를 입력하세요',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                try {
                  await controller.searchPlace(controller.searchController.text);
                  await controller.updateMarkers(context);
                } catch (e) {
                  SnackBar(content: Text(
                      '연결이 불안정합니다',
                      style: TextStyle(
                          color: Colors.black
                      )), backgroundColor: Colors.white,
                  );
                }
              },
            ),
          ),
          onSubmitted: (value) async {
            FocusScope.of(context).unfocus();
            try {
              await controller.searchPlace(value);
              await controller.updateMarkers(context);
            } catch (e) {
              SnackBar(content: Text(
                  '연결이 불안정합니다',
                  style: TextStyle(
                      color: Colors.black
                  )), backgroundColor: Colors.white,
              );
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [

              // 지도 영역: 검색된 장소를 지도에 표시
              Container(
                width: double.infinity,
                height: height * 0.35,
                child: NaverMap(
                  onMapReady: (mapController) {
                    controller.setMapController(mapController);
                  },
                  options: const NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(37.5665, 126.9780),
                      zoom: 12,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.015),

              // 검색결과 리스트: 사용자가 검색한 장소들을 리스트로 보여줌
              Expanded(
                child: Obx(() => ListView.separated(
                  itemCount: controller.places.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.shade300,
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final place = controller.places[index];
                    final isSelected =
                        controller.selectedPlace.value?['id'] == place['id'];

                    return ListTile(
                      selected: isSelected,
                      selectedTileColor: Colors.grey.shade200,
                      title: Text(
                        place['place_name'] ?? '',
                        style: TextStyle(
                          fontSize: 14.3,
                          color: isSelected ? Colors.black : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        place['road_address_name'] ?? '',
                        style: TextStyle(
                          fontSize: 14.3,
                          color: isSelected ? Colors.black : Colors.grey.shade600,
                        ),
                      ),
                      onTap: () async {
                        controller.selectPlace(place);
                        try {
                          controller.mapController.updateCamera(
                            NCameraUpdate.scrollAndZoomTo(
                              target: NLatLng(
                                double.parse(place['y']),
                                double.parse(place['x']),
                              ),
                              zoom: width > 500 ? 14 : 15,
                            ),
                          );
                        } catch (_) {}
                      },
                    );
                  },
                )),
              ),
            ],
          ),

          // 선택 버튼: 사용자가 선택한 장소를 추가할 수 있는 버튼
          Obx(() {
            if (controller.selectedPlace.value == null) return const SizedBox.shrink();
            final place = controller.selectedPlace.value!;
            return Positioned(
              bottom: height * 0.02,
              left: width * 0.235,
              width: width * 0.53,
              height: height * 0.055,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD3351E),
                  foregroundColor: Colors.white,
                  fixedSize: Size(width * 0.53, height * 0.055),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '이 장소 추가하기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            );
          }),
        ],
      ),
    );
  }
}