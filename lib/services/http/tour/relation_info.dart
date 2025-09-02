import '../../dio/unauthorized_dio.dart';

Future<Map<String, dynamic>>relatedPlaceInfo(String placeName) async {
  try {
    final dio = await getUnauthorizedDio();
    final response = await dio.get('http://3.34.44.187:80/tour/relation_info/?place_name=$placeName');
    return response.data;
  } catch (e) {
    throw Exception("relationInfo Error: $e");
  }
}
