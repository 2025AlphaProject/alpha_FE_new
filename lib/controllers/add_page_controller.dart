import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/tour/category/category_name_to_id.dart';
import '../helper/tour/get_sido_list/filter_area_name.dart';
import '../helper/tour/get_sido_list/filter_sido_name.dart';
import '../helper/tour/get_sido_list/sido_code_match.dart';
import '../helper/user/me/filter_sub.dart';
import '../services/http/tour/get_area_list.dart';
import '../services/http/tour/get_sido_list.dart';
import '../services/http/user/me.dart';
import '../services/websocket/show_tour_course/show_tour_course_websocket.dart';


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
  RxString areaCode = ''.obs;
  
  ///웹소켓 연동 값
  final ShowTourCourseWebsocket _websocket = ShowTourCourseWebsocket();
  final RxBool hasError = false.obs;
  final RxBool isLoading = false.obs;

  final textController = TextEditingController();
  RxBool isButtonAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSidoList();
    fetchAreaList();

    ever(selectedName, (String value) {
      isButtonAvailable.value = value.trim().isNotEmpty;
    });
  }

  //TODO: 뒤로가기 시 데이터 초기화

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

  void fetchAITour() async {
    isLoading.value = true;
    final rawIdData = await userMe();
    final userId = filterSub(rawIdData);
    final categoryIdList = categoryNameToId(selectedCategory);
    _websocket.connect(
        userId: userId,
        areaCode: areaCode.value,
        areaName: selectedSmallPlace.value,
        categoryNumber: categoryIdList,
        onData: (data) {
          fetchedTour.value = data['result'];
          isLoading.value = false;
          },
        onError: () {
          hasError.value = true;
        }
    );
  }

  void disconnect() {
    _websocket.disconnect();
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
    print(userTour);
    selectedIds.clear();
  }

  Future<void> fetchSidoList() async {
    // TODO: 이미지 받아오기 및 데이터 매핑 필요
    final rawData = await tourGetSidoList();
    sidoListName.value = filterSidoName(rawData);
  }

  Future<void> fetchAreaList() async {
    isAreaCodeLoading.value = true;
    final rawData = await tourGetAreaList();
    areaCode.value = sidoCodeMatch[selectedBigPlace.value]!;
    areaListName.value = ['선택 x', ...filterAreaName(rawData, areaCode.value)];
    isAreaCodeLoading.value = false;
  }

  bool isSelected(String category) => selectedCategory.contains(category);


  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}