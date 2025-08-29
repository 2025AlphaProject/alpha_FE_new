import 'category/category_match.dart';

/// 장소 모델
class TourPlace {
  final int id;
  final int tdpId;
  final String name;
  final double mapX;
  final double mapY;
  final String roadAddress;
  final String address;
  final String contenttypeid;
  final String place_image;
  final String categoryName;

  const TourPlace({
    required this.id,
    required this.tdpId,
    required this.name,
    required this.mapX,
    required this.mapY,
    required this.roadAddress,
    required this.address,
    required this.contenttypeid,
    required this.place_image,
    required this.categoryName,
  });

  factory TourPlace.fromMap(Map<String, dynamic> map, {required int tdpId}) {
    final contentIdStr = (map['contenttypeid'] as String? ?? '').trim();
    final CategoryName = getCategoryName(contentIdStr);
    return TourPlace(
      id: (map['id'] as num?)?.toInt() ?? 0,
      tdpId: tdpId,
      name: map['name'] as String? ?? '',
      mapX: (map['mapX'] as num?)?.toDouble() ?? 0.0,
      mapY: (map['mapY'] as num?)?.toDouble() ?? 0.0,
      roadAddress: map['road_address'] as String? ?? '',
      address: map['address'] as String? ?? '',
      contenttypeid: map['contenttypeid'] as String? ?? '',
      place_image: map['place_image'] as String? ?? '',
      categoryName: CategoryName,
    );
  }
}