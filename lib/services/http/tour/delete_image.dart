import '../../dio/authorized_dio.dart';

Future<void> deleteTourImage(int tourId) async {
  final dio = await getAuthorizedDio();
  try {
    final response = await dio.delete(
        'http://13.125.50.220/tour/image/$tourId/',
    );
  } catch (e) {
    throw Exception("deleteTourImage Error: $e");
    // TODO: 네트워크 오류 발생 및 서버 오류 발생 시 예외 처리
  }
}