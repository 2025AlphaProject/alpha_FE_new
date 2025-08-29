List<int> filterAiTourId(List<Map<String, dynamic>> data) {
  return data.map((item) => item['id'] as int).toList();
}