import 'package:dio/dio.dart';

import '../../dio/authorized_dio.dart';

Future<Response> missionImageUpload(String imagePath, int tdpId) async {
  final dio = await getAuthorizedDio();

  final formData = FormData.fromMap({
    'travel_days_id': tdpId.toString(),
    'image': await MultipartFile.fromFile(imagePath),
  });

  try {
    final response = await dio.post(
      'http://13.125.50.220/mission/image_upload/',
      data: formData,
    );
    return response;
  } catch (e) {
    throw Exception("MissionImageUpload Error: $e");
  }
}