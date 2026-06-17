
List<Map<String, dynamic>> getTourImage(List<Map<String, dynamic>> tourImages) {
  List<Map<String, dynamic>> imageUrls = [];

  for (var image in tourImages) {
    imageUrls.add({
      'image_id': image['id'],
      'image': image['image'],
    });
  }
  return imageUrls;
}