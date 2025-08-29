import 'package:flutter/material.dart';

final Map<String, IconData> nearPlaceCategoryIcons = {
  "관광지": Icons.map_outlined,       // 관광 시설
  "문화관광": Icons.account_balance,   //문화 시설
  "역사관광": Icons.account_balance, // 역사 시설
  "도시공원" : Icons.park,           //공원
  "숙박": Icons.hotel,              // 숙박
  "쇼핑": Icons.shopping_cart,      // 쇼핑
  "음식": Icons.restaurant,         // 음식점
  "카페/찻집": Icons.local_cafe,     //카페
};

IconData? placeCategory(String cat1, String cat2, String cat3) {
  if (nearPlaceCategoryIcons.containsKey(cat3)) return nearPlaceCategoryIcons[cat3];
  if (nearPlaceCategoryIcons.containsKey(cat2)) return nearPlaceCategoryIcons[cat2];
  if (nearPlaceCategoryIcons.containsKey(cat1)) return nearPlaceCategoryIcons[cat1];
  return Icons.place; // 기본 아이콘
}
