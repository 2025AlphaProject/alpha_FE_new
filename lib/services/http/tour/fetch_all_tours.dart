import '../../dio/authorized_dio.dart';

Future<List<dynamic>> fetchAllTours() async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://13.125.50.220/tour/');
    return response.data;
  } catch (e) {
    throw Exception("fetchAllTours Error: $e");
  }
}
