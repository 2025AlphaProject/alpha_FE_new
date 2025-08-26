import 'dart:io';

import 'package:get/get.dart';

import '../components/images/pick_image.dart';
import '../helper/tour/get_tour/filter_image_path.dart';
import '../services/http/tour/get_tour.dart';
import '../services/http/tour/get_image.dart';
import '../services/http/tour/post_image.dart';

class MyPageController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<dynamic> userTour = <dynamic>[].obs;

  RxInt selectedTourId = 0.obs;
  RxString selectedTourName = ''.obs;
  RxString selectedTourDate = ''.obs;
  RxString selectedTourArea = ''.obs;
  RxList<String> userDetailTourImage = <String>[].obs;

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
  }

  Future<void> getUserDetailTours() async {
    isLoading.value = true;
    final rawData = await getTourImage(selectedTourId.value);
    userDetailTourImage.value = filterImagePath(rawData);
    isLoading.value = false;
  }

  void pickAndUploadImage() async {
    final File? image = await pickImage();
    if (image != null) {
      await postImage(image, selectedTourId.value);
      getUserDetailTours();
    }
  }
}