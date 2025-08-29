import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Dio> getKakaoAuthorizedDio() async {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://dapi.kakao.com/v2/local',
    headers: {
      'Authorization': 'KakaoAK ${dotenv.env['KAKAO_REST_KEY']}',
    },
  ));
  return dio;
}
