import 'package:conever/services/dio/kakao_authorized_dio.dart';
import 'package:get/get.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

final logger = Logger();

class SearchPlaceController extends GetxController {
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


  // 키워드로 장소를 검색하는 함수
  Future<List<Map<String, dynamic>>> searchPlace(String query) async {
    const String url = '/search/keyword.json';
    final dio = await getKakaoAuthorizedDio();
    try {
      final response = await dio.get(
        url,
        queryParameters: {'query': query},
      );

      final docs = response.data['documents'] as List<dynamic>;

      final seoulDocs = docs.where((doc) {
        final addr = doc['road_address_name'] ?? '';
        return addr.startsWith('서울');
      }).map((e) {
        final modified = Map<String, dynamic>.from(e);
        if (modified['road_address_name'] != null &&
            modified['road_address_name'].startsWith('서울')) {
          modified['road_address_name'] =
              modified['road_address_name'].replaceFirst('서울', '서울특별시');
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

  // 지도 위에 마커를 업데이트하는 함수
  Future<void> updateMarkers(BuildContext context) async {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = 430;
    try {
      // 기존 마커 삭제
      for (final marker in markers) {
        mapController.deleteOverlay(
          NOverlayInfo(type: NOverlayType.marker, id: marker.info.id),
        );
      }
      markers.clear();

      // 새로운 마커 추가
      for (final place in places) {
        final marker = NMarker(
          id: place['id'],
          position: NLatLng(
            double.parse(place['y']),
            double.parse(place['x']),
          ),
        );
        mapController.addOverlay(marker);
        markers.add(marker);
      }

      // 카메라 위치 및 줌 레벨 조정
      if (places.isNotEmpty) {
        mapController.updateCamera(
          NCameraUpdate.scrollAndZoomTo(
            target: NLatLng(
              double.parse(places[0]['y']),
              double.parse(places[0]['x']),
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

  // 사용자가 장소를 선택했을 때 선택 상태를 업데이트하는 함수
  void selectPlace(Map<String, dynamic> place) {
    selectedPlace.value = place;
  }

  // 네이버 지도 컨트롤러를 설정하는 함수
  void setMapController(NaverMapController controller) {
    mapController = controller;
  }

  // 검색 결과 및 상태를 초기화하는 함수
  void clear() {
    places.clear();
    selectedPlace.value = null;
    markers.clear();
    searchController.clear();
  }
}