List<String> filterSidoName(List<dynamic> getSidoList) {
  return getSidoList.map((item) => item['name'] as String).toList();
}
