import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/http/tour/fetch_tour_recommendation.dart';

class AddPageController extends GetxController {
  RxBool isAiToggled = false.obs;
  // RxBool isButtonReady = true.obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxString selectedName = "".obs;
  RxString selectedBigPlace = "서울".obs;
  RxString selectedSmallPlace = "선택 X".obs;
  RxList<String> selectedCategory = <String>[].obs;

  RxMap<String, dynamic> fetchedTour = <String, dynamic>{}.obs;
  RxList<Map<String, dynamic>> userTour = <Map<String, dynamic>>[].obs;
  RxSet<String> selectedIds = <String>{}.obs;

  int get tourLength => selectedIds.length;

  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTour();
    // everAll([selectedBigPlace, isAiToggled], (_) {
    //   if (!isAiToggled.value) {
    //     selectedBigPlace.value = "서울";
    //     isButtonReady.value = true;
    //   } else {
    //     if (selectedBigPlace.value.isNotEmpty) {
    //       isButtonReady.value = true;
    //     } else {
    //       isButtonReady.value = false;
    //     }
    //   }
    // });
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
            picked.add(Map<String, dynamic>.from(item)); // 원본 유지용 깊은 복사
            seen.add(id);
          }
        }
      }
    });
    userTour.assignAll(picked);
    selectedIds.clear();
  }

  bool isSelected(String category) => selectedCategory.contains(category);
}