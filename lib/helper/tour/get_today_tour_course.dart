import 'package:conever/helper/tour/tour_place.dart';
import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import 'package:flutter/foundation.dart';
import 'package:conever/controllers/home_page_controller.dart';
import 'package:get/get.dart';



void getTodayTourCourse(int id) async {

  debugPrint('loadTodayTour: 실행 시작');
  final controller = Get.find<HomePageController>();

  try {
    controller.isLoading.value = true;
    controller.errorMessage.value = '';

    final tourData = await fetchTourCourses(id);
    debugPrint("HomePageController: 오늘의 여행 정보 가져오기 성공: ${tourData['id']}" );

    // 사용자 정보
    final List<Map<String, dynamic>> rawUsers = List<Map<String, dynamic>>.from(tourData['user'] ?? []);
    debugPrint('HomePageController: 오늘의 여행 users: ${rawUsers}');

    // 장소 목록
    final List<Map<String, dynamic>> rawPlaces = List<Map<String, dynamic>>.from(tourData['places'] ?? []);
    controller.places.assignAll(
      rawPlaces.map((each) {
        final tdpId = (each['tdp_id'] as num?)?.toInt() ?? 0;
        final placeMap = each['place'] as Map<String, dynamic>? ?? const {};
        return TourPlace.fromMap(placeMap, tdpId: tdpId);
      }),
    );


  } catch (e) {
    debugPrint('getTodayTourCourse: 오늘의 여행 정보 가져오기 실패: $e');
    controller.errorMessage.value = '데이터 로딩 중 오류가 발생했습니다.';
  } finally {
    controller.isLoading.value = false;
  }

}