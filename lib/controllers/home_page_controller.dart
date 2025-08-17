import '../helper/tour/category/category_match.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../dummy/get_dummy_tour_list.dart';

/// 장소 모델
class TourPlace {
  final int id;
  final int tdpId;
  final String name;
  final double mapX;
  final double mapY;
  final String roadAddress;
  final String address;
  final String contentid;
  final String imageUrl;
  final String categoryName;

  const TourPlace({
    required this.id,
    required this.tdpId,
    required this.name,
    required this.mapX,
    required this.mapY,
    required this.roadAddress,
    required this.address,
    required this.contentid,
    required this.imageUrl,
    required this.categoryName,
  });

  factory TourPlace.fromMap(Map<String, dynamic> map, {required int tdpId}) {
    final contentIdStr = (map['contentid'] as String? ?? '').trim();
    final resolvedCategoryName = getCategoryName(contentIdStr);
    return TourPlace(
      id: (map['id'] as num?)?.toInt() ?? 0,
      tdpId: tdpId,
      name: map['name'] as String? ?? '',
      mapX: (map['mapX'] as num?)?.toDouble() ?? 0.0,
      mapY: (map['mapY'] as num?)?.toDouble() ?? 0.0,
      roadAddress: map['road_address'] as String? ?? '',
      address: map['address'] as String? ?? '',
      contentid: map['contentid'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      categoryName: resolvedCategoryName,
    );
  }
}

/// 홈 페이지 전역 상태
class HomePageController extends GetxController {
  // 투어 기본 정보
  final RxInt tourId = 0.obs;
  final RxString tourName = ''.obs;
  final RxString tourDate = ''.obs; // 서버 문자열 그대로 저장

  // 사용자: 개수만 관리
  final RxInt userCount = 0.obs;

  // 장소 목록
  final RxList<TourPlace> places = <TourPlace>[].obs;

  // 로딩/에러 상태
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // 카테고리 전역 상태
  final RxList<String> categories = <String>[].obs; // ['전체', '관광지', '숙박', ...]
  final RxString selectedCategory = '전체'.obs; // 현재 선택된 카테고리

  // 선택된 카테고리에 따른 필터 결과
  List<TourPlace> get filteredPlaces {
    final sel = selectedCategory.value;
    if (sel == '전체' || sel.isEmpty) return places;
    return places.where((p) => p.categoryName == sel).toList();
  }

  // 카테고리 선택 변경
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onInit() {
    super.onInit();
    // 더미 데이터 로딩
    loadDummyTour();
    debugPrint('HomePageController: 더미데이터 로딩 완료');
  }

  /// 더미 데이터 → 전역 상태로 적재
  void loadDummyTour() {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = getDummyTourList();

      // 투어 정보
      tourId.value = (data['id'] as num?)?.toInt() ?? 0;
      tourName.value = data['tour_name'] as String? ?? '';
      tourDate.value = data['tour_date'] as String? ?? '';
      debugPrint(
        'tour: id=' +
            tourId.value.toString() +
            ', name=' +
            tourName.value +
            ', date=' +
            tourDate.value,
      );

      // 사용자 수
      final rawUsers = data['user'] as List<dynamic>? ?? const [];
      userCount.value = rawUsers.length;
      debugPrint('users: count=' + userCount.value.toString());

      // 장소 목록
      final rawPlaces = data['places'] as List<dynamic>? ?? const [];
      places.assignAll(
        rawPlaces.map((e) {
          final row = e as Map<String, dynamic>;
          final tdpId = (row['tdp_id'] as num?)?.toInt() ?? 0;
          final placeMap = row['place'] as Map<String, dynamic>? ?? const {};
          return TourPlace.fromMap(placeMap, tdpId: tdpId);
        }),
      );
      // 카테고리 목록/카운트 생성
      final counts = <String, int>{};
      for (final p in places) {
        counts[p.categoryName] = (counts[p.categoryName] ?? 0) + 1;
      }
      final list = counts.keys.toList();
      categories.assignAll(['전체', ...list]);
      debugPrint('places: count=' + places.length.toString());
    } catch (e) {
      errorMessage.value = '데이터 로딩 중 오류가 발생했습니다.';
    } finally {
      isLoading.value = false;
    }
  }
}
