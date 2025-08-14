import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> saveRefreshToken(String? token) async {await secureStorage.write(key: 'refresh_token', value: token);}

Future<String?> getRefreshToken() async {return await secureStorage.read(key: 'refresh_token');}

Future<void> deleteRefreshToken() async {await secureStorage.delete(key: 'refresh_token');}

Future<void> saveAccessToken(String? token) async {await secureStorage.write(key: 'access_token', value: token);}

Future<String?> getAccessToken() async {return await secureStorage.read(key: 'access_token');}

Future<void> deleteAccessToken() async {await secureStorage.delete(key: 'access_token');}