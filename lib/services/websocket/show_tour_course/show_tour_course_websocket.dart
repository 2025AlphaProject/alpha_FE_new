import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:web_socket_channel/web_socket_channel.dart';

class ShowTourCourseWebsocket {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  void connect({
    required String userId,
    required String areaCode,
    required String areaName,
    required List<String> categoryNumber,
    required Function(dynamic data) onData,
    required Function onError,
  }) {
    final uniqueCode = Random().nextInt(1 << 31);
    if (areaName == '선택 X') {
      areaName = '';
    }
    String categoryList = categoryNumber.join(',');
    final wsUrl = 'ws://3.34.125.36:80/tour/recommend/?user_id=$userId&areaCode=$areaCode&sigunguName=$areaName&unique_code=$uniqueCode&categoryName=$categoryList';

    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    _subscription = _channel!.stream.listen(
          (message) {
        final data = jsonDecode(message);
        onData(data);
      },
      onError: (_) => onError(),
      cancelOnError: true,
    );
  }

  void disconnect() {
    _subscription?.cancel();
    _channel?.sink.close();
  }
}