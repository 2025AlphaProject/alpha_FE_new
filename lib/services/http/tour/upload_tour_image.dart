import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../dio/authorized_dio.dart';

Future<Response> TourImageUpload(String imagePath, int id) async {
  final dio = await getAuthorizedDio();

  debugPrint('imagePath: $imagePath');
  debugPrint('tdpId: $id');
  final formData = FormData.fromMap({
    'tour_id': id.toString(),
    'image': await MultipartFile.fromFile(imagePath),
  });

  try {
    final response = await dio.post(
      'http://3.34.125.36:80/tour/image/',
      data: formData,
    );
    return response;
  } catch (e) {
    throw Exception("MissionImageUpload Error: $e");
  }
}