
import 'get_access_token_from_refresh_token.dart';

Future<bool> testAccessToken() async {
  try {
    await getAccessTokenFromRefreshToken();
    return true;
  } catch (e) {
    return false;
  }
}