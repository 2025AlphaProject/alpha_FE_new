import 'package:conever/services/dio/authorized_dio.dart';
import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import 'package:flutter/foundation.dart';
import 'fetch_all_tours.dart';

Future<List<Map<String, dynamic>>> fetchTodayTour() async {
  debugPrint('fetchTodayTour: 호출 시작');

  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.44.187:80/tour/today/');

    // response.data를 안전하게 List<Map<String, dynamic>>로 변환
    final List<dynamic> data = response.data;
    final tours = data.map((e) => e as Map<String, dynamic>).toList();

    debugPrint('fetchTodayTour: 응답 수신 $tours');
    return tours;
  } catch (e) {
    rethrow;
  }
}
