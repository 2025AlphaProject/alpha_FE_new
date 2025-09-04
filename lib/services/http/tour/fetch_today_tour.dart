import 'package:conever/services/dio/authorized_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<List<Map<String, dynamic>>> fetchTodayTour() async {
  debugPrint('fetchTodayTour: 호출 시작');

  try {
    final dio = await getAuthorizedDio();
    final response = await dio.get('http://3.34.44.187:80/tour/today/');

    final List<dynamic> data = response.data;
    final tours = data.map((e) => e as Map<String, dynamic>).toList();
    return tours;
  } on DioException catch (e) {
    final status = e.response?.statusCode;
    if (status != null && status >= 500 && status < 600) {
      Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('서버 오류', style: TextStyle(fontWeight: FontWeight.bold),),
          content: const Text('서버에 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFD3351E),
              ),
                onPressed: () => Get.back(),
                child: Text('확인')
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
    rethrow;
  }
  catch (e) {
    throw Exception("fetchTodayTour Error: $e");
  }
}
