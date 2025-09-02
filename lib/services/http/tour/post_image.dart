import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../dio/authorized_dio.dart';

Future<void> postImage(File imageFile, int tourId) async {
  final dio = await getAuthorizedDio();

  final fileName = basename(imageFile.path);
  final formData = FormData.fromMap({
    'image': await MultipartFile.fromFile(
      imageFile.path,
      filename: fileName,
    ),
    'tour_id': tourId,
  });

  try {
    final response = await dio.post(
      'http://3.34.125.36/tour/image/',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

  } catch (e) {
    throw Exception('postImage Error: $e');
  }
}