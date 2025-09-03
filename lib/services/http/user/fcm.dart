import '../../dio/authorized_dio.dart';

Future<void> postFCMToken(fcmToken) async {
  try {
    final dio = await getAuthorizedDio();
    await dio.post(
        'http://3.34.44.187:80/user/fcm/',
      data: {'fcm_token': fcmToken}
    );
  } catch (e) {
    throw Exception("postFCMToken Error: $e");
  }
}