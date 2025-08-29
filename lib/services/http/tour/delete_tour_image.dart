import 'package:conever/services/dio/authorized_dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Future<void> deleteTourImage (int imageId) async {
  try {
    final dio = await getAuthorizedDio();
    await dio.delete(
      'http://3.34.125.36:80/tour/image/$imageId/'
    );
    Get.snackbar("성공", "이미지 삭제 완료");
  }
  catch(e) {
    debugPrint('deleteTourImage 에러 발생: $e');
    Get.snackbar("실패", "이미지 삭제 실패");
  }
}