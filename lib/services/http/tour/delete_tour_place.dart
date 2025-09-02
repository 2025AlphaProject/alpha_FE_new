import '../../dio/authorized_dio.dart';

Future<bool> deleteTourPlace(int id, int pid) async {
  try {
    final dio = await getAuthorizedDio();
    final response = await dio.patch(
        'http://3.34.44.187:80/tour/$id/',
        data: {
          "places": {
            "delete_places":[pid]
          },
        }
    );
    return response.statusCode == 200;
  } catch (e) {
    throw Exception("deleteTourById Error: $e");
  }
}