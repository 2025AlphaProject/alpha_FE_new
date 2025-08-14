import 'package:flutter/material.dart';

import '../../dio/authorized_dio.dart';
class ShowTourCourseApi {
  final String baseUrl = 'http://3.34.125.36:80';

  Future<int?> fetchUserId() async {
    final dio = await getAuthorizedDio();
    for (int i = 0; i < 3; i++) {
      try {
        final response = await dio.get('$baseUrl/user/me/');
        return response.data['sub'];
      } catch (_) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    return null;
  }

  //원래 Fetch Tour Info 가 있었?
}