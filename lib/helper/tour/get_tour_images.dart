
List<String> getTourImage(List<Map<String, dynamic>> tourImages) {
  List<String> imageUrls = [];

  for (var image in tourImages) {
    imageUrls.add(image['image']);
  }
  return imageUrls;
}