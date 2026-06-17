import '../../dio/authorized_dio.dart';

Future<void> postFCMToken(fcmToken) async {
  try {
    final dio = await getAuthorizedDio();
    await dio.post(
        'http://13.125.50.220/user/fcm/',
      data: {'fcm_token': fcmToken}
    );
  } catch (e) {
    throw Exception("postFCMToken Error: $e");
  }
}