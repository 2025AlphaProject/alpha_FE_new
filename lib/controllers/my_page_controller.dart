import 'dart:io';

import 'package:get/get.dart';

import '../components/images/pick_image.dart';
import '../helper/tour/get_tour/filter_image_path.dart';
import '../helper/tour/get_tour/map_image_to_id.dart';
import '../services/http/tour/delete_image.dart';
import '../services/http/tour/delete_snapshot.dart';
import '../services/http/tour/get_snapshot.dart';
import '../services/http/tour/get_tour.dart';
import '../services/http/tour/get_image.dart';
import '../services/http/tour/post_image.dart';

class MyPageController extends GetxController {
  RxList<String> userFourCutImage = <String>[].obs;
  RxMap<String, int> fourCutImageWithId = <String, int>{}.obs;

  RxList<dynamic> userTour = <dynamic>[].obs;

  RxInt selectedTourId = 0.obs;
  RxString selectedTourName = ''.obs;
  RxString selectedTourDate = ''.obs;
  RxString selectedTourArea = ''.obs;
  RxList<String> userDetailTourImage = <String>[].obs;
  RxMap<String, int> tourImageWithId = <String, int>{}.obs;

  RxString selectedImagePath = ''.obs;

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
    final rawData = await getTourImage(selectedTourId.value);
    userDetailTourImage.value = filterImagePath(rawData);
    tourImageWithId.value = mapImageToId(rawData);
  }

  void pickAndUploadImage() async {
    final File? image = await pickImage();
    if (image != null) {
      await postImage(image, selectedTourId.value);
      await getUserTours();
      await getUserDetailTours();
    }
  }

  Future<void> deleteImage() async {
    final imageId = tourImageWithId[selectedImagePath.value];
    await deleteTourImage(imageId!);
    await getUserTours();
    await getUserDetailTours();
  }

  Future<void> getFourCutImages() async {
    final rawData = await getSnapshot();
    userFourCutImage.value = filterImagePath(rawData);
    fourCutImageWithId.value = mapImageToId(rawData);
  }

  Future<void> deleteFourCut() async {
    final imageId = fourCutImageWithId[selectedImagePath.value];
    await deleteSnapshot(imageId!);
    await getFourCutImages();
  }
}