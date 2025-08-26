import '../../dio/authorized_dio.dart';

Future<List<dynamic>> getTour() async {
  final dio = await getAuthorizedDio();
  try {
    final response = await dio.get('http://3.34.125.36/tour/');
    return response.data;
  } catch (e) {
    throw Exception("getTour Error: $e");
    // TODO: 네트워크 오류 발생 및 서버 오류 발생 시 예외 처리
  }
}