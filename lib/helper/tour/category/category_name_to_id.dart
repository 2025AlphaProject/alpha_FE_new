import 'category_match.dart';

List<String> categoryNameToId(List<String> categoryNameList) {
  final List<String> result = [];
  for (int i = 0; i < categoryNameList.length; i++) {
    final categoryName = categoryNameList[i];
    final categoryId = getCategoryId(categoryName);
    result.add(categoryId);
  }
  return result;
}