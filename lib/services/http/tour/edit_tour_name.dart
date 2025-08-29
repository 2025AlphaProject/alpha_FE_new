import '../../dio/authorized_dio.dart';

Future<void> editTourName(int id, String editedTourName) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.patch(
        'http://3.34.125.36:80/tour/$id/',
      data: {
          'tour_name': editedTourName,
      }
    );
  } catch (e) {
    throw Exception("deleteTourById Error: $e");
  }
}