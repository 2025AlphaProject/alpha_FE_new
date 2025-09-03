import 'package:flutter/foundation.dart';

class AddedPlace {
  // 출력용 필드

  final String name;
  final String mapX;
  final String mapY;
  final String roadAddress;
  final String address;

  // 내부 식별용 원본 Kakao id (UI 토글용)
  final String? sourceId;

  // 생성자

  const AddedPlace({
    required this.name,
    required this.mapX,
    required this.mapY,
    required this.roadAddress,
    required this.address,
    this.sourceId,
  });

  // Kakao 검색 문서에서 필요한 필드만 추출

  factory AddedPlace.fromKakaoDoc(Map<String, dynamic> doc) {
    return AddedPlace(
      name: doc['place_name'] ?? '',
      mapX: doc['x']?.toString() ?? '',
      mapY: doc['y']?.toString() ?? '',
      roadAddress: doc['road_address_name'] ?? '',
      address: doc['address_name'] ?? '',
      sourceId: doc['id']?.toString(),
    );
  }

  // 외부 전달용 Map 변환

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mapX': mapX,
      'mapY': mapY,
      'road_address': roadAddress,
      'address': address,
    };
  }

  // 동일성 비교를 Kakao id 기준으로 처리

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AddedPlace && runtimeType == other.runtimeType && sourceId == other.sourceId;

  @override
  int get hashCode => sourceId.hashCode;
}