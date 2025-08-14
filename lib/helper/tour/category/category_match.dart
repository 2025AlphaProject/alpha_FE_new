import 'package:flutter/material.dart';

final Map<String, String> categoryNames = {
  "12": "관광지",
  "14": "문화시설",
  "15": "축제공연행사",
  "28": "레포츠",
  "32": "숙박",
  "38": "쇼핑",
  "39": "음식점",
};

String getCategoryName(String id) {
  return categoryNames[id] ?? "알 수 없는 카테고리";
}

final Map<String, IconData> categoryIcons = {
  "12": Icons.map_outlined,       // 관광지
  "14": Icons.account_balance,    // 문화시설
  "15": Icons.theater_comedy,     // 축제/공연/행사
  "28": Icons.sports_kabaddi,     // 레포츠
  "32": Icons.hotel,              // 숙박
  "38": Icons.shopping_cart,      // 쇼핑
  "39": Icons.restaurant,         // 음식점
};

IconData getCategoryIcon(String id) {
  return categoryIcons[id] ?? Icons.help_outline;
}