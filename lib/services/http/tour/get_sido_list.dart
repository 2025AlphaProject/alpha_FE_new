import '../../dio/unauthorized_dio.dart';

Future<List<dynamic>> getSidoList() async {
  final dio = await getUnauthorizedDio();
  try {
    final response = await dio.get('http://3.34.125.36/tour/get_sido_list/');
    return response.data;
  } catch (e) {
    throw Exception("getSidoList Error: $e");
    // TODO: 네트워크 오류 발생 및 서버 오류 발생 시 예외 처리
  }
}