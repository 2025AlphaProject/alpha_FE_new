import '../../dio/authorized_dio.dart';

Future<List<Map<String, dynamic>>> fetchAllUsers() async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.44.187:80/user/');
    return List<Map<String, dynamic>>.from(response.data);
  } catch (e) {
    throw Exception("FetchAllUsers Error: $e");
  }
}