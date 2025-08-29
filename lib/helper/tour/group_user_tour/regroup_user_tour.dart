import 'dart:collection';

Map<String, List<Map<String, dynamic>>> regroupUserTour(List<dynamic> tours) {
  final Map<String, List<Map<String, dynamic>>> rawGroupedTours = {};

  for (var tour in tours) {
    final year = tour['tour_date']?.substring(0, 4) ?? '알 수 없음';
    rawGroupedTours.putIfAbsent(year, () => []).add(tour);
  }

  final groupedTours = LinkedHashMap<String, List<Map<String, dynamic>>>.fromEntries(
    rawGroupedTours.entries.toList()
      ..sort((a, b) {
        if (a.key == '알 수 없음') return 1;
        if (b.key == '알 수 없음') return -1;
        return int.parse(b.key).compareTo(int.parse(a.key));
      }),
  );

  return groupedTours;
}