Map<String, String> mapSidoToImage(List<String> sidoList, List<String> sidoImage) {
  final Map<String, String> result = {};
  for (int i = 0; i < sidoList.length; i++) {
    result[sidoList[i]] = sidoImage[i];
  }
  return result;
}