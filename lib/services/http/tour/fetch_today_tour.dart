import 'package:conever/services/dio/authorized_dio.dart';
import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import 'fetch_all_tours.dart';

Future<Map<String, dynamic>> fetchTodayTour() async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.125.36:80/tour/today/');
    return response.data;
  } catch (e) {
    throw Exception("getTodayTour Error: $e");
  }
}
