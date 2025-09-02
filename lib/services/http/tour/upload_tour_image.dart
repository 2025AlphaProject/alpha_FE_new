import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> tourImageUpload(String imagePath, int id) async {
  final dio = await getAuthorizedDio();

  debugPrint('imagePath: $imagePath');
  debugPrint('tdpId: $id');
  final formData = FormData.fromMap({
    'tour_id': id.toString(),
    'image': await MultipartFile.fromFile(imagePath),
  });

  try {
    final response = await dio.post(
      'http://3.34.44.187:80/tour/image/',
      data: formData,
    );
    return response.data;
  } catch (e) {
    throw Exception("MissionImageUpload Error: $e");
  }
}