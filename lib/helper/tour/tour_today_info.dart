import 'category/category_match.dart';

class TourTodayInfo {
  final int tourId;
  final String tourName;
  final String tourDate;
  final int peopleCnt;
  final int imageCnt;
  final int placeCnt;
  final List<String> categoryList;
  final List<String> tourAreaInfo;

  TourTodayInfo({
    required this.tourId,
    required this.tourName,
    required this.tourDate,
    required this.peopleCnt,
    required this.imageCnt,
    required this.placeCnt,
    required this.categoryList,
    required this.tourAreaInfo,
  });

  factory TourTodayInfo.fromJson(Map<String, dynamic> json) {
    final rawCategories = (json['category_list'] as List?)?.cast<int>() ?? [];
    final mappedCategories = rawCategories.map((code) {
      // category_match.dart의 getCategoryName으로 카테고리 이름 변환
      return getCategoryName(code.toString());
    }).toList();

    return TourTodayInfo(
      tourId: json['tour_id'] ?? 0,
      tourName: json['tour_name'] ?? '',
      tourDate: json['tour_date'] ?? '',
      peopleCnt: json['people_cnt'] ?? 0,
      imageCnt: json['image_cnt'] ?? 0,
      placeCnt: json['place_cnt'] ?? 0,
      categoryList: ['전체', ...mappedCategories],
      tourAreaInfo: List<String>.from(json['tour_area_info'] ?? []),
    );
  }
}