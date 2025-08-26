import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/services/http/tour/fetch_all_tours.dart';
import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import 'package:conever/services/http/tour/edit_tour_name.dart';

import 'package:conever/services/http/user/add_user_to_tour.dart';
import 'package:conever/services/http/user/fetch_all_users.dart';

class PlanPageController extends GetxController{
  RxList<Map<String, dynamic>> cards = <Map<String, dynamic>>[].obs; //내 여행 정보 저장
  RxMap<String, dynamic> course = <String, dynamic>{}.obs; // 특정 여행 정보 저장
  RxList<Map<String, dynamic>> user = <Map<String, dynamic>>[].obs; // 전체 유저 정보 저장
  RxBool isEditMode = false.obs; //특정 여행 편집 모드 여부
  late var sortCriteria = '날짜순'.obs;
  late final PageController pageController;

  @override
  void onInit(){
    super.onInit();
    pageController = PageController(viewportFraction: 0.85);
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
    } catch (e) {
      print('특정 여행정보 에러 : $e');
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
      await Future.delayed(Duration(milliseconds: 40));
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
    print(now);
  }
}