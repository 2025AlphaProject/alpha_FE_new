import 'package:conever/services/dio/authorized_dio.dart';


Future<List<Map<String, dynamic>>> fetchTourImages(int id) async {
  final dio = await getAuthorizedDio();

  try {
    final response = await dio.get('http://13.125.50.220/tour/image?tour=$id');
    return (response.data as List).cast<Map<String, dynamic>>();
  }
  catch (e) {
    throw Exception("fetchTourImage Error: $e");
  }


}

