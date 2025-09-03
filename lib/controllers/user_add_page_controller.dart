import 'package:conever/services/dio/kakao_authorized_dio.dart';
import 'package:get/get.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../helper/tour/added_place.dart';
import '../pages/add_page/user_add_page/components/user_add_place_list_sheet.dart';

final logger = Logger();

class UserAddPageController extends GetxController {
  // 검색어 입력을 위한 텍스트 컨트롤러

  final TextEditingController searchController = TextEditingController();

  // 네이버 지도 컨트롤러

  late NaverMapController mapController;

  // 검색된 장소 목록 상태 관리

  var places = <Map<String, dynamic>>[].obs;

  // 사용자가 선택한 장소 상태 관리

  var selectedPlace = Rxn<Map<String, dynamic>>();

  // 지도에 표시할 마커 목록 상태 관리

  var markers = <NMarker>[].obs;

  // 추가된 장소 목록 상태 관리

  final addedPlaces = <AddedPlace>[].obs;

  // 서울 필터 및 텍스트 치환을 포함한 키워드 검색

  Future<List<Map<String, dynamic>>> searchPlace(String query) async {
    const String url = '/search/keyword.json';
    final dio = await getKakaoAuthorizedDio();
    try {
      final response = await dio.get(url, queryParameters: {'query': query});
      final docs = response.data['documents'] as List<dynamic>;

      // 서울 주소만 허용하고 '서울' → '서울특별시' 치환

      final seoulDocs = docs.where((doc) {
        final addr = doc['road_address_name'] ?? '';
        return addr.startsWith('서울');
      }).map((e) {
        final modified = Map<String, dynamic>.from(e);
        if (modified['road_address_name'] != null &&
            modified['road_address_name'].toString().startsWith('서울')) {
          modified['road_address_name'] =
              modified['road_address_name'].toString().replaceFirst('서울', '서울특별시');
        }
        return modified;
      }).toList();

      places.assignAll(seoulDocs);
      selectedPlace.value = null;
      return seoulDocs;
    } catch (e) {
      logger.e('장소 검색 실패: $e');
      rethrow;
    }
  }

  // 지도 위에 마커를 업데이트

  Future<void> updateMarkers(BuildContext context) async {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    try {
      for (final marker in markers) {
        mapController.deleteOverlay(
          NOverlayInfo(type: NOverlayType.marker, id: marker.info.id),
        );
      }
      markers.clear();

      for (final place in places) {
        final marker = NMarker(
          id: place['id'].toString(),
          position: NLatLng(
            double.parse(place['y'].toString()),
            double.parse(place['x'].toString()),
          ),
        );
        mapController.addOverlay(marker);
        markers.add(marker);
      }

      if (places.isNotEmpty) {
        mapController.updateCamera(
          NCameraUpdate.scrollAndZoomTo(
            target: NLatLng(
              double.parse(places[0]['y'].toString()),
              double.parse(places[0]['x'].toString()),
            ),
            zoom: width > 500 ? 13 : 14,
          ),
        );
      }
    } catch (e) {
      logger.e('마커 업데이트 실패: $e');
      rethrow;
    }
  }

  // 장소 선택 상태 갱신

  void selectPlace(Map<String, dynamic> place) {
    selectedPlace.value = place;
  }

  // 지도 컨트롤러 설정

  void setMapController(NaverMapController controller) {
    mapController = controller;
  }

  // 목록에 장소 추가

  void addPlaceFromDoc(Map<String, dynamic> doc) {
    try {
      final kakaoId = doc['id']?.toString();
      if (kakaoId == null) return;

      // 이미 추가된 항목은 중복 추가 방지

      final already = addedPlaces.any((p) => p.sourceId == kakaoId);
      if (already) return;

      final added = AddedPlace.fromKakaoDoc(doc);
      addedPlaces.add(added);
    } catch (e) {
      logger.e('장소 추가 실패: $e');
    }
  }

  // Kakao id 기준 추가 여부 확인

  bool isAdded(String kakaoId) {
    return addedPlaces.any((p) => p.sourceId == kakaoId);
  }

  // 목록 BottomSheet 열기

  void openListSheet(BuildContext context) {
    Get.bottomSheet(
      const UserAddPlaceListSheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
      backgroundColor: Colors.transparent,
    );
  }

  // 상태 초기화

  void clear() {
    places.clear();
    selectedPlace.value = null;
    markers.clear();
    searchController.clear();
    addedPlaces.clear();
  }
}