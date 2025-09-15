import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import '../../controllers/login_page_controller.dart';
import 'save_access_and_refresh_token.dart';

Future<void> loginTestUser() async {
  try {
    final dio = Dio();
    final formData = FormData.fromMap({'id_token': "tester"});

    final response = await dio.post(
      'http://3.34.44.187:80/auth/login/',
      data: formData,
      options: Options(headers: {'Accept': 'application/json'}),
    );
    await saveAccessToken(response.data['tokens']['access_token']);
    await saveRefreshToken(response.data['tokens']['refresh_token']);
    print('ac:${response.data['tokens']['access_token']}');

    if (response.data['user']['privacy_policy_agree']) {
      Get.find<LoginPageController>().isTesterPrivacyAgreed.value = true;
      await savePrivacyAgreement(true);
    }

  } catch (e) {
    throw Exception("loginTestUser error: $e");
  }
}