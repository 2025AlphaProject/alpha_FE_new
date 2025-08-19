import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dummy/fetch_tour_recommendation.dart';
import '../helper/tour/get_sido_list/filter_area_name.dart';
import '../helper/tour/get_sido_list/filter_sido_name.dart';
import '../helper/tour/get_sido_list/sido_code_match.dart';
import '../services/http/tour/get_area_list.dart';
import '../services/http/tour/get_sido_list.dart';


class AddPageController extends GetxController {
  /// 사용자 입력 값
  RxBool isAiToggled = false.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxString selectedName = "".obs;
  RxString selectedBigPlace = "서울".obs;
  RxString selectedSmallPlace = "선택 X".obs;
  RxList<String> selectedCategory = <String>[].obs;
  RxSet<String> selectedIds = <String>{}.obs;
  RxList<Map<String, dynamic>> userTour = <Map<String, dynamic>>[].obs;
  int get tourLength => selectedIds.length;

  ///API 연동 값
  RxMap<String, dynamic> fetchedTour = <String, dynamic>{}.obs;
  // RxMap<String, dynamic> sidoListAndImage = <String, dynamic>{}.obs;
  RxList<String> sidoListName = <String>[].obs;
  RxList<String> areaListName = <String>[].obs;
  RxBool isAreaCodeLoading = false.obs;

  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTour();
    fetchSidoList();
    fetchAreaList();
  }

  //TODO: 뒤로가기 시 지워야하는데 해야하는데 왜 시@발 안되는걸까 흠흠

  void toggleSelect(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    selectedIds.refresh();
  }
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  void toggleCategory(String category) {
    if (selectedCategory.contains(category)) {
      selectedCategory.remove(category);
    } else {
      selectedCategory.add(category);
    }
  }

  Future<void> fetchTour() async {
    fetchedTour.value = await fetchTourRecommendation();
  }

  void saveSelectedAiTours() {
    final List<Map<String, dynamic>> picked = [];
    final seen = <String>{};

    fetchedTour.forEach((_, list) {
      if (list is List) {
        for (final item in list) {
          final id = '${item['contentId'] ?? ''}';
          if (id.isNotEmpty && selectedIds.contains(id) && !seen.contains(id)) {
            picked.add(Map<String, dynamic>.from(item));
            seen.add(id);
          }
        }
      }
    });
    userTour.assignAll(picked);
    selectedIds.clear();
  }

  Future<void> fetchSidoList() async {
    // TODO: 이미지 받아오기 및 데이터 매핑 필요
    final rawData = await getSidoList();
    sidoListName.value = filterSidoName(rawData);
  }

  Future<void> fetchAreaList() async {
    isAreaCodeLoading.value = true;
    final rawData = await getAreaList();
    final areaCode = sidoCodeMatch[selectedBigPlace.value];
    areaListName.value = ['선택 x', ...filterAreaName(rawData, areaCode!)];
    isAreaCodeLoading.value = false;
  }

  bool isSelected(String category) => selectedCategory.contains(category);
}