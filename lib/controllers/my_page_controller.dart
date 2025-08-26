import 'package:get/get.dart';

import '../services/http/tour/get_tour.dart';

class MyPageController extends GetxController {
  RxList<dynamic> userTour = <dynamic>[].obs;

  RxInt selectPage = 0.obs;
  RxBool isSelectingFrame = false.obs;
  RxList<String> selectedPaths = <String>[].obs;

  bool isSelected(String path) => selectedPaths.contains(path);

  void toggleSelect(String path) {
    if (isSelected(path)) {
      selectedPaths.remove(path);
    } else {
      selectedPaths.add(path);
    }
  }

  void toggleIsSelectingFrame() {
    if (isSelectingFrame.value == true) {
      selectedPaths.value = [];
      isSelectingFrame.value = false;
    } else {
      isSelectingFrame.value = true;
    }
  }

  Future<void> getUserTours() async {
    userTour.value = await getTour();
    print(userTour);
  }
}