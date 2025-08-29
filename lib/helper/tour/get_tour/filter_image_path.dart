List<String> filterImagePath(List<dynamic> rawData) {
  return rawData.map((item) => item['image'] as String).toList();
}