import '../dio/unauthorized_dio.dart';
import 'save_access_and_refresh_token.dart';

Future<void> getAccessTokenFromRefreshToken() async {
  final refreshToken = await getRefreshToken();
  print("refreshToken: $refreshToken");
  try {
    final dio = await getUnauthorizedDio();
    final response = await dio.post(
      'http://3.34.44.187:80/auth/refresh/',
      data: {
        'refresh_token': refreshToken,
      },
    );
    print('access token: ${response.data['access_token']}');
    saveAccessToken(response.data['access_token']);
    saveRefreshToken(response.data['refresh_token']);
  } catch (e) {
    throw Exception("getAccessTokenFromRefresh Token Error: $e");
  }
}