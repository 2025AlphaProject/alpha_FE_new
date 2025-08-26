Map<String, int> mapImageToId(List<dynamic> rawData) {
  return {
    for (var item in rawData)
      item['image']: item['id']
  };
}