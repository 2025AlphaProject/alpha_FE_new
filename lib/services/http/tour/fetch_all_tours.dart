import '../../dio/authorized_dio.dart';

Future<List<dynamic>> fetchAllTours() async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.44.187:80/tour/');
    return response.data;
  } catch (e) {
    throw Exception("fetchAllTours Error: $e");
  }
}
