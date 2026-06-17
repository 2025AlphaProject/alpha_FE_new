import '../../dio/authorized_dio.dart';

Future<bool> editTourName(int id, String editedTourName) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.patch(
        'http://13.125.50.220/tour/$id/',
      data: {
          'tour_name': editedTourName,
      }
    ); return response.statusCode == 200;
  } catch (e) {
    throw Exception("deleteTourById Error: $e");
  }
}