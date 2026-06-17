import '../../dio/authorized_dio.dart';

Future<bool> editTourDate(int id, String editedTourDate) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.patch(
        'http://13.125.50.220/tour/$id/',
        data: {
          'tour_date': editedTourDate,
        }
    );
    return response.statusCode == 200;
  } catch (e) {
    throw Exception("deleteTourById Error: $e");
  }
}