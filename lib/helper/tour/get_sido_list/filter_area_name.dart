List<String> filterAreaName(Map<String, dynamic> getAreaList, String areaCode) {
  final areaList = getAreaList[areaCode];
  if (areaList == null || areaList is! List) return [];

  return areaList
      .map<String>((item) => item['name'].toString())
      .toList();
}