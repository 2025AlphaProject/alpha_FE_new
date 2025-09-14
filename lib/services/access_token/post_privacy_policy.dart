
import 'package:conever/services/dio/authorized_dio.dart';

Future<Map<String, dynamic>> postPrivacyPolicy({
  required bool privacyPolicyAgree,
  required String privacyPolicyVersion
}) async {
  try {
    final dio = await getAuthorizedDio();
    final res = await dio.post('http://3.34.44.187:80/user/privacy_policy/',
    data: {
      'privacy_policy_agree': privacyPolicyAgree,
      'privacy_policy_version': privacyPolicyVersion
    });
    return res.data;
  } catch (e) {
    rethrow;
  }
}