import '../../dio/authorized_dio.dart';

Future<List<Map<String, dynamic>>> fetchAllUsers() async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://13.125.50.220/user/');
    return List<Map<String, dynamic>>.from(response.data);
  } catch (e) {
    throw Exception("FetchAllUsers Error: $e");
  }
}