
import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> fetchTourPose(int place_id) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.125.36:80/tour/pose-rec/$place_id/');
    return response.data;
  } catch (e) {
    throw Exception("fetchTourPose Error: $e");

  }

}