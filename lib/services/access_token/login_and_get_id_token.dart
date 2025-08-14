import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'get_access_and_refresh_token.dart';
import 'package:flutter/services.dart';

class KakaoLoginService {
  static Future<bool> login({
    required String nativeKey,
    required String jsKey,
  }) async {
    if (kIsWeb) {
      KakaoSdk.init(javaScriptAppKey: jsKey);
    } else {
      KakaoSdk.init(nativeAppKey: nativeKey);
    }

    try {
      OAuthToken token;
      if (kIsWeb) {
        token = await UserApi.instance.loginWithKakaoAccount();
      } else if (await isKakaoTalkInstalled()) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (_) {
          token = await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      var user = await UserApi.instance.me();
      final scopes = <String>[];
      if (user.kakaoAccount?.profileNeedsAgreement == true) {
        scopes.add('profile_nickname');
      }
      if (scopes.isNotEmpty) {
        await UserApi.instance.loginWithNewScopes(scopes);
        user = await UserApi.instance.me();
      }

      await getAccessAndRefreshToken(token);
      return true;
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        return false;
      }
      rethrow;
    }
  }
}