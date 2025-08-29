import 'package:conever/services/dio/authorized_dio.dart';
import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import 'package:flutter/foundation.dart';
import 'fetch_all_tours.dart';

Future<Map<String, dynamic>> fetchTodayTour() async {
  debugPrint('fetchTodayTour: 호출 시작');

  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.125.36:80/tour/today/');
    debugPrint('fetchTodayTour: 응답 수신 ${response.data}');
    return response.data;
  } catch (e) {
    rethrow;
  }
}
