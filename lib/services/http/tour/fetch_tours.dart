import 'package:dio/dio.dart';

import '../../dio/authorized_dio.dart';

Future<Response> fetchTours(int id) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.125.36:80/tour/$id/');
    return response.data;
  } catch (e) {
    throw Exception("fetchTourCourses Error: $e");
  }
}