import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../services/http/tour/upload_tour_image.dart';

Future<void> pickAndUploadImage(ImageSource source, int tourId) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    final imagePath = pickedFile.path;
    try {
      final response = await TourImageUpload(imagePath, tourId);
      // 업로드 성공 시 사용자에게 알림
      Get.snackbar("성공", "이미지 업로드 완료");
    } catch (e) {
      Get.snackbar("실패", "이미지 업로드 실패: $e");
    }
  } else {
    Get.snackbar("취소됨", "이미지를 선택하지 않았습니다");
  }
}