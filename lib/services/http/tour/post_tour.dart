import 'package:flutter/foundation.dart';

import '../../dio/authorized_dio.dart';

Future<void> postTour({
  required String tourName,
  required String tourDate,
  required List<int> aiTourPlaceIds,
  required List<Map<String, dynamic>> userTourPlaces,
}) async {
  final dio = await getAuthorizedDio();
  try {
    debugPrint('data: ${
        {
          'tour_name': tourName,
          'tour_date': tourDate,
          'places': {
            'place_ids': aiTourPlaceIds,
            'additional_info': [],
            'custom_places': userTourPlaces
          }
        }
    }');
    await dio.post('http://13.125.50.220/tour/', data:
      {
        'tour_name': tourName,
        'tour_date': tourDate,
        'places': {
          'place_ids': aiTourPlaceIds,
          'additional_info': [],
          'custom_places': userTourPlaces
        }
      }
      );
  } catch (e) {
    throw Exception("postTour Error: $e");
    // TODO: 네트워크 오류 발생 및 서버 오류 발생 시 예외 처리
  }
}