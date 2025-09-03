class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = '인터넷 연결을 확인해주세요']);
  @override
  String toString() => message;
}