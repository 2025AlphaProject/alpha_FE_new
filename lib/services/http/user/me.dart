
import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> userMe() async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.44.187:80/user/me/');
    return response.data;
  } catch (e) {
    throw Exception("userMe Error: $e");
  }
}