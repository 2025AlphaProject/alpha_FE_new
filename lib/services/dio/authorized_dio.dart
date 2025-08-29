import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../access_token/save_access_and_refresh_token.dart';

Future<Dio> getAuthorizedDio() async {
  final dio = Dio();
  final accessToken = await getAccessToken();
  debugPrint('getAuthorizedDio: $accessToken');
  dio.options.headers = {
    'Authorization': 'Bearer $accessToken',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  return dio;
}
