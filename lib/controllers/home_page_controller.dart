import 'package:conever/helper/tour/get_tour_images.dart';
import 'package:conever/services/http/tour/fetch_today_tour.dart';
import 'package:conever/services/http/tour/fetch_tour_pose.dart';
import 'package:dio/dio.dart';

import '../helper/tour/get_today_tour_course.dart';
import '../helper/tour/category/category_match.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/tour/tour_place.dart';
import '../services/http/tour/fetch_tour_image.dart';
import '../services/http/user/fetch_my_info.dart';

/// 홈 페이지 전역 상태
class HomePageController extends GetxController {

  // 유저 정보
  final RxString userName = ''.obs;
  final RxString userProfile = ''.obs;

  // 투어 기본 정보
  final RxInt tourId = 0.obs;
  final RxString tourName = ''.obs;
  final RxString tourDate = ''.obs; // 서버 문자열 그대로 저장

  // 사용자 수
  final RxInt userCount = 0.obs;

  // 업로드 한 이미지 수
  final RxInt imageCount = 0.obs;

  // 총 장소 개수
  final RxInt placeCount = 0.obs;

  // 여행 지역
  final RxString region = ''.obs;

  // 장소 목록
  final RxList<TourPlace> places = <TourPlace>[].obs;

  // 로딩/에러 상태
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool todayTourNotFound = false.obs;

  // 카테고리 전역 상태
  final RxList<String> categories = <String>[].obs; // ['전체', '관광지', '숙박', ...]
  final RxString selectedCategory = '전체'.obs; // 현재 선택된 카테고리

  // 선택된 카테고리에 따른 필터 결과
  List<TourPlace> get filteredPlaces {
    final sel = selectedCategory.value;
    if (sel == '전체' || sel.isEmpty) return places;
    return places.where((p) => p.categoryName == sel).toList();
  }

  // 카테고리 선택 변경
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // 포즈 추천 리스트
  final RxList<String> poses = <String>[].obs;
  final RxList<String> poseImages = <String>[].obs;

  // 업로드된 여행 사진 url
  final RxList<Map<String, dynamic>> tourImages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    debugPrint('HomePageController: 컨트롤러 등록 완료');
  }

  Future<void> _loadInitialData() async {
    await loadUserData();
    await loadTodayTour();
    await loadTodayCourses();
    await loadTourImages(tourId.value);
  }

  Future<void> loadUserData() async {
    debugPrint('loadUserData: 실행 시작');
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await FetchMyInfo();

      userName.value = data['username'] as String? ?? '';
      userProfile.value = data['profile_image_url'] as String? ?? '';

      isLoading.value = false;
  }
  catch (e) {
    debugPrint('HomePageController: 유저 정보 가져오기 실패: $e');
    isLoading.value = false;
    errorMessage.value = '데이터 로딩 중 오류가 발생했습니다.';
    }
  }

  Future<void> loadTodayTour() async {
    debugPrint('loadTodayTour: 실행 시작');
    try {
      debugPrint('loadTodayTour: try 구문 진입');

      isLoading.value = true;
      errorMessage.value = '';

      debugPrint('loadTodayTour: fetchTodayTour 진입');
      final tourData = await fetchTodayTour();

      // 카테고리 id와 일치하는 카테고리명 삽입
      final list = <String>[];
      for (final pid in tourData['category_list']) {
        list.add(getCategoryName(pid.toString()));
      }
      categories.assignAll(['전체', ...list]);

      tourId.value = tourData['tour_id'] as int? ?? 0;
      tourName.value = tourData['tour_name'] as String? ?? '';
      tourDate.value = tourData['tour_date'] as String? ?? '';
      userCount.value = tourData['people_cnt'] as int? ?? 0;
      imageCount.value = tourData['image_cnt'] as int? ?? 0;
      placeCount.value = tourData['place_cnt'] as int? ?? 0;
      region.value = tourData['tour_area_info'].isNotEmpty ? tourData['tour_area_info'][0] as String : '';

      debugPrint('loadTodayTour: 실행 완료, imageCount: ${imageCount.value}');


      isLoading.value = false;
    } on DioException catch(e) {
      debugPrint('loadTodayTour: DioException 발생: $e');
      isLoading.value = false;
      if (e.response?.statusCode == 404) {
        todayTourNotFound.value = true;
      }
    }
    catch (e) {
      debugPrint('HomePageController: 오늘의 여행 정보 가져오기 실패: $e');
      isLoading.value = false;
      errorMessage.value = '데이터 로딩 중 오류가 발생했습니다.';
    }

  }

  Future<void> loadTodayCourses() async {
    isLoading.value = true;
    getTodayTourCourse(tourId.value);

    isLoading.value = false;
  }

  Future<void> loadTourPoses(int place_id) async {
    debugPrint('loadTourPoses: 실행 시작');
    isLoading.value = true;

    final data = await fetchTourPose(place_id);
    poses.value = List<String>.from(data['poses'] ?? []);
    poseImages.value = List<String>.from(data['images'] ?? []);

    isLoading.value = false;
  }

  Future<void> loadTourImages(int tour_id) async {
    debugPrint('loadTourImages: 실행 시작');
    isLoading.value = true;

    final data = await fetchTourImages(tour_id);
    debugPrint('loadTourImages: 실행 완료, data: $data');
    tourImages.value = data;

    isLoading.value = false;
  }
}
