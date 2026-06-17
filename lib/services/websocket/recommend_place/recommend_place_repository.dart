import 'dart:math';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../socket_manager.dart';
import 'recommend_place.dart';

class RecommendPlaceRepository {
  Future<(WebSocketChannel?, int?, String)> createRecommendationChannel() async {
    final userId = await RecommendPlaceService.fetchUserId();
    if (userId == null) return (null, null, '');

    final randomDistrict = RecommendPlaceService.getRandomDistrict();
    final uniqueCode = Random().nextInt(1 << 31);

    final uri =
        'ws://13.125.50.220/tour/recommend/?user_id=$userId&areaCode=1&sigunguName=$randomDistrict&unique_code=$uniqueCode&days=1';

    final channel = WebSocketManager.connect(uri);
    return (channel, userId, randomDistrict);
  }
}