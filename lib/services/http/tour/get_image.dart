import '../../dio/authorized_dio.dart';

Future<List<dynamic>> getTourImage(int tourId) async {
  final dio = await getAuthorizedDio();
  try {
    final response = await dio.get(
        'http://3.34.125.36/tour/image/',
      data: {
          'tour': tourId,
      }
    );
    return response.data;
  } catch (e) {
    throw Exception("tourImage Error: $e");
    // TODO: 네트워크 오류 발생 및 서버 오류 발생 시 예외 처리
  }
}