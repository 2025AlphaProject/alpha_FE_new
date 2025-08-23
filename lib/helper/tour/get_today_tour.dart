import 'package:conever/services/http/tour/fetch_tour_courses.dart';
import '../../services/http/tour/fetch_all_tours.dart';

Future<Map<String, dynamic>> getTodayTour() async {
  // 전체 여행 데이터 가져오기
  final allTours = await fetchAllTours();

  // 오늘 날짜를 yyyy-MM-dd 형식 문자열로 구하기
  final today = DateTime.now();
  final todayStr = "${today.year.toString().padLeft(4, '0')}-"
      "${today.month.toString().padLeft(2, '0')}-"
      "${today.day.toString().padLeft(2, '0')}";

  // 오늘 날짜와 같은 여행만 남기기
  final todayTours = allTours.where((tour) =>
  tour['tour_date'] == todayStr
  ).toList();

  // 그 중에 하나만 사용
  final todayTourCourse = await fetchTourCourses(todayTours[0].id);

  return todayTourCourse;
}
