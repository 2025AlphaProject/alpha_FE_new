List<String> filterSidoImage(List<dynamic> getSidoList) {
  return getSidoList.map((item) => item['image'] as String).toList();
}
