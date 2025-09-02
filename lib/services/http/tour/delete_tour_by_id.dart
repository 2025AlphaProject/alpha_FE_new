import '../../dio/authorized_dio.dart';

Future<bool> deleteTourById(int id) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.delete('http://3.34.125.36:80/tour/$id/');
    return response.statusCode == 204;
  } catch (e) {
    throw Exception("deleteTourById Error: $e");
  }
}