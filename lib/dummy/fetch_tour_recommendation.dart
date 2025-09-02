import '../../../dummy/get_dummy_tour_recommendation.dart';

Future<Map<String, dynamic>> fetchTourRecommendation() async {
  final rawData = getDummyTourRecommendation();
  return rawData['result'];
}