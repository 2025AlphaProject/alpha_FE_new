import 'package:dio/dio.dart';

import '../../dio/unauthorized_dio.dart';

Future<Response> fetchEventsFromApi(double mapX, double mapY) async {
  final dio = await getUnauthorizedDio();
  try {
    final response = await dio.get(
        'http://3.34.125.36:80/tour/near_event/',
        queryParameters: {
        'mapX': mapX,
        'mapY': mapY,
        });
    return response.data;
  } catch (e) {
    throw Exception("fetchEventsFromApi Error: $e");
  }
}