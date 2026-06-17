import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'save_access_and_refresh_token.dart';

Future<void> getAccessAndRefreshToken(OAuthToken token) async {
  try {
    final dio = Dio();
    final formData = FormData.fromMap({'id_token': token.idToken});

    final response = await dio.post(
      'http://13.125.50.220/auth/login/',
      data: formData,
      options: Options(headers: {'Accept': 'application/json'}),
    );
    await saveAccessToken(response.data['tokens']['access_token']);
    await saveRefreshToken(response.data['tokens']['refresh_token']);
    await savePrivacyAgreement(response.data['user']['privacy_policy_agree']);

  } catch (e) {
    throw Exception("getAccessAndRefreshToken error: $e");
  }
}