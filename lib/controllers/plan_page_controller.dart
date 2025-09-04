import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../services/http/tour/delete_tour_by_id.dart';
import '../services/http/tour/delete_tour_place.dart';
import '../services/http/tour/edit_tour_date.dart';
import '../services/http/tour/edit_tour_name.dart';
import '../services/http/tour/fetch_all_tours.dart';
import '../services/http/tour/fetch_tour_courses.dart';
import '../services/http/tour/relation_info.dart';
import '../services/http/user/add_user_to_tour.dart';
import '../services/http/user/fetch_all_users.dart';

class PlanPageController extends GetxController{
  RxList<Map<String, dynamic>> cards = <Map<String, dynamic>>[].obs; //내 여행 정보 저장
  RxMap<String, dynamic> course = <String, dynamic>{}.obs;// 특정 여행 정보 저장
  RxMap<String, dynamic> relatedPlaces = <String, dynamic>{}.obs; //연관 관광 장소 정보 저장
  RxList<Map<String, dynamic>> user = <Map<String, dynamic>>[].obs; // 전체 유저 정보 저장
  RxBool isEditMode = false.obs; //특정 여행 편집 모드 여부
  Rx<DateTime> selectedDay = DateTime.now().obs;
  late var sortCriteria = '날짜순'.obs;
  late final PageController pageController;

  @override
  void onInit(){
    super.onInit();
    pageController = PageController(viewportFraction: 0.85);

  }

  @override
  void onReady() {
    super.onReady();
    loadTours();
  }

  //내 여행 전부 가져오기
  Future<void> loadTours() async {
    final data = await fetchAllTours() ;
    cards.assignAll(data.cast<Map<String, dynamic>>());
    sortCriteria.value = '날짜순';
    sortCards();
  }

  // 특정 여행 정보 가져오기
  Future<void> tourCourse(int tourId) async {
    try {
      final data = await fetchTourCourses(tourId);
      final parsed = Map<String, dynamic>.from(data);
      course.assignAll(parsed);
      _userList();
      selectedDay.value = _parseDate(course['tour_date']);

    } catch (e) {
      print('특정 여행정보 에러 : $e');
    }
  }

  //연관 관광 장소 가져오기
  Future<bool> loadRelatedPlaces(String place_name) async{
    try {
      final data = await relatedPlaceInfo(place_name);
      final parsed = Map<String, dynamic>.from(data);
      relatedPlaces.assignAll(parsed);
      await Future.delayed(Duration(milliseconds: 50));
      return true;
    } catch (e) {
      print('연관 관광 장소 에러 : $e');
      return false;
    }
  }

  //전체 유저 정보 가져오기
  Future<void> _userList() async {
    try {
      final data = await fetchAllUsers();

      // 특정 여행에 있는 유저의 sub 리스트 추출
      final existingSubs = (course['user'] as List)
          .map((u) => u['sub'].toString())
          .toSet();

      // 이미 포함된 사용자 제외하고 필터링
      final filtered = data
          .where((user) => !existingSubs.contains(user['sub'].toString()))
          .toList();

      user.assignAll(filtered.cast<Map<String, dynamic>>());
    } catch (e) {
      print('유저리스트 에러 : $e');
    }
  }

  //여행 동행자 추가(유저 추가)
  Future<bool> addUser(int sub, int tourId) async {
    try {
      final success = await addUserToTour(sub: sub, tourId: tourId);
      return success;
    } catch (e) {
      print("동행자 추가 에러: $e");
      return false; // ← 이게 없으면 오류 발생
    }
  }

  //여행 제목 수정
  Future<bool> editName(int tourId, String tourName) async {
    try{
      final success = await editTourName(tourId, tourName);
      loadTours();
      await Future.delayed(Duration(milliseconds: 1));
      return success;
    }catch(e){
      return false;
    }
  }

  //여행 날짜 수정
  Future<bool> editDate(int tourId,String tourDate) async{
    try{
      final success = await editTourDate(tourId, tourDate);
      loadTours();
      await Future.delayed(Duration(milliseconds: 1));
      return success;
    }catch(e){
      return false;
    }
  }

  //특정 여행의 특정 장소 삭제
  Future<bool> deletePlace(int tourId, int placeId) async {
    try{
      final success = await deleteTourPlace(tourId, placeId);
      loadTours();
      isEditMode.value = false;
      await Future.delayed(Duration(milliseconds: 1));
      return success;
    }catch(e){
      return false;
    }
  }

  //여행 삭제
  Future<bool> deleteTour(int tourId) async {
    try{
      final success = await deleteTourById(tourId);
      loadTours();
      await Future.delayed(Duration(milliseconds: 1));
      return success;
    }catch(e){
      return false;
    }
  }

  //날짜 형식 수정
  DateTime _parseDate(String dateStr) {
    return DateTime.parse(dateStr.replaceAll('.', '-')); // '2025.08.16' → '2025-08-16'
  }

  // 오늘 날짜와 가장 가까운 날짜의 인덱스를 찾는 헬퍼 함수
  int _findClosestDateIndex(List<Map<String, dynamic>> cardList) {
    if (cardList.isEmpty) return 0;
    final now = DateTime.now();
    int closestIdx = 0;
    int minDiff = (_parseDate(cardList[0]['tour_date']).difference(now)).abs().inDays;
    int diff = (_parseDate(cardList[0]['tour_date']).difference(now)).abs().inDays;
    for (int i = 1; i < cardList.length; i++) {
      diff = (_parseDate(cardList[i]['tour_date']).difference(now)).abs().inDays;
      if (diff < minDiff) {
        minDiff = diff;
        closestIdx = i;
      }
    }
    return closestIdx;
  }

  //여행을 기준대로 정렬
  Future<void> sortCards() async {
    final criteria = sortCriteria.value;
    final sorted = [...cards];
    if (criteria == '이름순' || criteria.toLowerCase().contains('tour_name')) {
      sorted.sort((a, b) => ((a['tour_name'] as String)?? '').compareTo((b['tour_name'] as String)?? ''));
    } else if (criteria == '날짜순' || criteria.toLowerCase().contains('tour_date')) {
      sorted.sort((a, b) => _parseDate((a['tour_date'] as String)?? '').compareTo(_parseDate((b['tour_date'] as String)?? '')));
    }
    cards.assignAll(sorted);
    int now = _findClosestDateIndex(cards);
    pageController.jumpToPage(now);
  }
}