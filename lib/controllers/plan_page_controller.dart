import 'package:conever/services/http/tour/fetch_all_tours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanPageController extends GetxController{
  var cards = <Map<String,dynamic>>[].obs; //여행 카드 정보 저장
  final sortCriteria = '날짜순'.obs;
  late final PageController pageController;

  @override
  void onInit(){
    super.onInit();
    pageController = PageController(viewportFraction: 0.85);
    _loadTours();
  }

  Future<void> _loadTours() async {
    try{
      final data = await fetchAllTours();
      cards.assignAll(data.cast<Map<String,dynamic>>());
      print('여기서 : $cards');
      _sortCards();
    } catch (e){
      print(e);
    }
  }

  //날짜 형식 수정
  DateTime _parseDate(String dateStr) {
    return DateTime.parse(dateStr.replaceAll('.', '-')); // '2025.08.16' → '2025-08-16'
  }

  //새롭게 기준 정렬해야 할때 사용
  void changeSortCriteria(String crtiteria){
    sortCriteria.value = crtiteria;
    _sortCards();
  }

  // 오늘 날짜와 가장 가까운 날짜의 인덱스를 찾는 헬퍼 함수
  int _findClosestDateIndex(List<Map<String, dynamic>> cardList) {
    if (cardList.isEmpty) return 0;
    final now = DateTime.now();
    int closestIdx = 0;
    int minDiff = (_parseDate(cardList[0]['date']).difference(now)).abs().inDays;
    for (int i = 1; i < cardList.length; i++) {
      final diff = (_parseDate(cardList[i]['date']).difference(now)).abs().inDays;
      if (diff < minDiff) {
        minDiff = diff;
        closestIdx = i;
      }
    }
    return closestIdx;
  }

  //여행을 기준대로 정렬
  void _sortCards() {
    final sorted = [...cards];
    if (sortCriteria.value == '이름순') {
      // 여행 이름을 기준으로 오름차순 정렬
      sorted.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));
    } else {
      // 날짜를 기준으로 오름차순 정렬
      sorted.sort((a, b) => _parseDate(a['date']).compareTo(_parseDate(b['date'])));
    }
    cards.assignAll(sorted);
    if (pageController.hasClients) {
      int jumpIdx = 0;
      jumpIdx = _findClosestDateIndex(sorted);
      pageController.jumpToPage(jumpIdx);
    }
  }
}