import '../../dio/authorized_dio.dart';

Future<bool> editTourDate(int id, String editedTourDate) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.patch(
        'http://3.34.125.36:80/tour/$id/',
        data: {
          'tour_date': editedTourDate,
        }
    );
    return response.statusCode == 200;
  } catch (e) {
    throw Exception("deleteTourById Error: $e");
  }
}