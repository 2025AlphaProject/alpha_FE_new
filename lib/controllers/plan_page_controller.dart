import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/services/http/tour/fetch_all_tours.dart';
import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import 'package:conever/services/http/tour/edit_tour_name.dart';
import 'package:conever/services/http/tour/delete_tour_by_id.dart';
import 'package:conever/services/http/tour/delete_tour_place.dart';
import 'package:conever/services/http/tour/edit_tour_date.dart';
import 'package:conever/services/http/tour/relation_info.dart';
import 'package:conever/services/http/user/add_user_to_tour.dart';
import 'package:conever/services/http/user/fetch_all_users.dart';

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
      // final data = await relatedPlaceInfo(place_name);
      // final parsed = Map<String, dynamic>.from(data);
      // relatedPlaces.assignAll(parsed);
      relatedPlaces.value = {
        "count": 49,
        "next": "http://3.34.125.36/tour/relation_info/?page=2&place_name=%EA%B2%BD%EB%B3%B5%EA%B6%81",
        "previous": null,
        "results": [
          {
            "id": 2,
            "related_place_detail_info": null,
            "related_place_name": "국립현대미술관/서울관",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "전시시설",
            "rank": 1,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 4,
            "related_place_detail_info": {
              "id": 18402,
              "name": "북촌한옥마을",
              "mapX": 126.9867060298,
              "mapY": 37.5790529392,
              "road_address": "서울특별시 종로구 계동길 37 (계동)",
              "address": null,
              "contenttypeid": "12",
              "place_image": "http://tong.visitkorea.or.kr/cms/resource/04/3304404_image2_1.jpg"
            },
            "related_place_name": "북촌한옥마을",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "역사관광",
            "related_place_cat3_name": "역사유적지",
            "rank": 3,
            "place": 1744,
            "related_place": 18402
          },
          {
            "id": 5,
            "related_place_detail_info": null,
            "related_place_name": "청와대사랑채",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "전시시설",
            "rank": 4,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 6,
            "related_place_detail_info": {
              "id": 42436,
              "name": "토속촌삼계탕",
              "mapX": 126.9715935592,
              "mapY": 37.5776167233,
              "road_address": "서울특별시 종로구 자하문로5길 5",
              "address": null,
              "contenttypeid": "39",
              "place_image": ""
            },
            "related_place_name": "토속촌삼계탕",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "음식",
            "related_place_cat2_name": "음식",
            "related_place_cat3_name": "한식",
            "rank": 5,
            "place": 1744,
            "related_place": 42436
          },
          {
            "id": 7,
            "related_place_detail_info": null,
            "related_place_name": "청와대/정문",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "기타관광",
            "related_place_cat3_name": "기타관광",
            "rank": 6,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 8,
            "related_place_detail_info": null,
            "related_place_name": "남산케이블카",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11140",
            "related_place_sigungu_name": "중구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "기타관광",
            "related_place_cat3_name": "기타관광",
            "rank": 7,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 9,
            "related_place_detail_info": {
              "id": 3345,
              "name": "광장시장",
              "mapX": 126.9997217621,
              "mapY": 37.5701653166,
              "road_address": "서울특별시 종로구 창경궁로 88",
              "address": "서울특별시 종로구 창경궁로 88",
              "contenttypeid": "38",
              "place_image": "http://tong.visitkorea.or.kr/cms/resource/81/2668981_image2_1.jpg"
            },
            "related_place_name": "광장시장",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "쇼핑",
            "related_place_cat3_name": "시장",
            "rank": 8,
            "place": 1744,
            "related_place": 3345
          },
          {
            "id": 10,
            "related_place_detail_info": null,
            "related_place_name": "삼청동수제비/본점",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "음식",
            "related_place_cat2_name": "음식",
            "related_place_cat3_name": "한식",
            "rank": 9,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 11,
            "related_place_detail_info": null,
            "related_place_name": "경복궁/[한식]",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "음식",
            "related_place_cat2_name": "음식",
            "related_place_cat3_name": "한식",
            "rank": 10,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 12,
            "related_place_detail_info": null,
            "related_place_name": "팔각정북악스카이",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "랜드마크관광",
            "rank": 11,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 13,
            "related_place_detail_info": null,
            "related_place_name": "YTN서울타워",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11170",
            "related_place_sigungu_name": "용산구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "랜드마크관광",
            "rank": 12,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 14,
            "related_place_detail_info": null,
            "related_place_name": "서울역",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11170",
            "related_place_sigungu_name": "용산구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "기타관광",
            "related_place_cat3_name": "교통시설",
            "rank": 13,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 15,
            "related_place_detail_info": null,
            "related_place_name": "청와대/춘추관",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "기타관광",
            "related_place_cat3_name": "기타관광",
            "rank": 14,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 16,
            "related_place_detail_info": {
              "id": 4019,
              "name": "국립고궁박물관",
              "mapX": 126.9749904992,
              "mapY": 37.576644675,
              "road_address": "서울특별시 종로구 효자로 12 (세종로)",
              "address": null,
              "contenttypeid": "14",
              "place_image": "http://tong.visitkorea.or.kr/cms/resource/75/3350375_image2_1.jpg"
            },
            "related_place_name": "국립고궁박물관",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "전시시설",
            "rank": 15,
            "place": 1744,
            "related_place": 4019
          },
          {
            "id": 17,
            "related_place_detail_info": null,
            "related_place_name": "애슐리퀸즈/종각역점",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "음식",
            "related_place_cat2_name": "음식",
            "related_place_cat3_name": "전문음식",
            "rank": 16,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 18,
            "related_place_detail_info": {
              "id": 20704,
              "name": "서대문형무소역사관",
              "mapX": 126.9555506693,
              "mapY": 37.5743584811,
              "road_address": "서울특별시 서대문구 통일로 251",
              "address": null,
              "contenttypeid": "14",
              "place_image": "http://tong.visitkorea.or.kr/cms/resource/29/3520329_image2_1.jpg"
            },
            "related_place_name": "서대문형무소역사관",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11410",
            "related_place_sigungu_name": "서대문구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "전시시설",
            "rank": 17,
            "place": 1744,
            "related_place": 20704
          },
          {
            "id": 19,
            "related_place_detail_info": {
              "id": 4112,
              "name": "국립중앙박물관",
              "mapX": 126.9791278024,
              "mapY": 37.5211706397,
              "road_address": "서울특별시 용산구 서빙고로 137 (용산동6가)",
              "address": null,
              "contenttypeid": "14",
              "place_image": "http://tong.visitkorea.or.kr/cms/resource/12/3495012_image2_1.jpg"
            },
            "related_place_name": "국립중앙박물관",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11170",
            "related_place_sigungu_name": "용산구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "문화관광",
            "related_place_cat3_name": "전시시설",
            "rank": 18,
            "place": 1744,
            "related_place": 4112
          },
          {
            "id": 20,
            "related_place_detail_info": null,
            "related_place_name": "창덕궁",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "역사관광",
            "related_place_cat3_name": "역사유적지",
            "rank": 19,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 21,
            "related_place_detail_info": null,
            "related_place_name": "101번지남산돈까스/본점",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11140",
            "related_place_sigungu_name": "중구",
            "related_place_cat1_name": "음식",
            "related_place_cat2_name": "음식",
            "related_place_cat3_name": "전문음식",
            "rank": 20,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 22,
            "related_place_detail_info": null,
            "related_place_name": "광화문미진/본점",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "음식",
            "related_place_cat2_name": "음식",
            "related_place_cat3_name": "한식",
            "rank": 21,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 23,
            "related_place_detail_info": null,
            "related_place_name": "조계사",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "역사관광",
            "related_place_cat3_name": "종교성지",
            "rank": 22,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 24,
            "related_place_detail_info": null,
            "related_place_name": "호텔스카이파크/동대문1호점",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11140",
            "related_place_sigungu_name": "중구",
            "related_place_cat1_name": "숙박",
            "related_place_cat2_name": "숙박",
            "related_place_cat3_name": "호텔",
            "rank": 23,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 25,
            "related_place_detail_info": null,
            "related_place_name": "북악스카이웨이",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "관광지",
            "related_place_cat2_name": "기타관광",
            "related_place_cat3_name": "데이트코스",
            "rank": 24,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 26,
            "related_place_detail_info": null,
            "related_place_name": "프레이저플레이스/남대문서울",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11140",
            "related_place_sigungu_name": "중구",
            "related_place_cat1_name": "숙박",
            "related_place_cat2_name": "숙박",
            "related_place_cat3_name": "호텔",
            "rank": 25,
            "place": 1744,
            "related_place": null
          },
          {
            "id": 27,
            "related_place_detail_info": null,
            "related_place_name": "이비스앰배서더/서울 인사동",
            "related_place_area_cd": "11",
            "related_place_area_name": "서울특별시",
            "related_place_sigungu_cd": "11110",
            "related_place_sigungu_name": "종로구",
            "related_place_cat1_name": "숙박",
            "related_place_cat2_name": "숙박",
            "related_place_cat3_name": "호텔",
            "rank": 26,
            "place": 1744,
            "related_place": null
          }
        ]
      };
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