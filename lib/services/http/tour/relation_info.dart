import '../../dio/unauthorized_dio.dart';

Future<Map<String, dynamic>>relatedPlaceInfo(String placeName) async {
  try {
    final dio = await getUnauthorizedDio();
    final response = await dio.get('http://13.125.50.220/tour/relation_info/?place_name=$placeName');
    return response.data;
  } catch (e) {
    throw Exception("relationInfo Error: $e");
  }
}
