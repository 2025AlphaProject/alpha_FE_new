import 'package:conever/pages/plan_page/plan_page_2/components/place_info.dart';
import 'package:conever/pages/plan_page/plan_page_2/components/travel_info.dart';
import 'package:conever/controllers/plan_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanPage2 extends GetView<PlanPageController> {
  final int tour_id;
  const PlanPage2({super.key, required this.tour_id});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      final trip = controller.course;
      if (trip.isEmpty) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final String title = trip['tour_name']?.toString() ?? '';
      final String date = trip['tour_date']?.toString().replaceAll('-', '.') ?? '';

      final List<dynamic> places =
          (trip['places'] is List) ? trip['places'] as List<dynamic> : [];

      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TravelInfo(
                  date: date,
                  title: title,
                  travelers: trip['user'] as List<dynamic>,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(width * 0.034, height * 0.01, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        '나의 여행지',
                        style: TextStyle(
                          fontSize: width * 0.058,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: width * 0.55),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('편집 누름')),
                          );
                        },
                        icon: const Icon(Icons.edit, color: Color(0xFFD3351E)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.012),
                ...places.map((e) { //여행 장소들 나타내기
                  final p = e['place'] as Map<String, dynamic>;
                  return PlaceInfo(
                    name: p['name']?.toString() ?? '',
                    road_address: p['road_address']?.toString() ?? '',
                    address: p['address']?.toString() ?? '',
                    imageURL: '',
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      );
    });
  }
}



// class PlanPage2 extends StatefulWidget {
//   final int tour_id;
//   const PlanPage2({super.key, required this. tour_id});
//
//   @override
//   State<PlanPage2> createState() => _PlanPage2State();
// }
//
// class _PlanPage2State extends State<PlanPage2> {
//   final Map<String, dynamic> _trip =
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     final String title = _trip['tour_name'] as String;
//     final String date = (_trip['tour_date'] as String).replaceAll('-', '.');
//     final List<dynamic> places = _trip['places'] as List<dynamic>;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.all(0),
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TravelInfo(date: date, title: title, travelers:_trip['user'] as List<dynamic>),
//               Container(
//                 padding: EdgeInsets.fromLTRB(width * 0.034,height*0.01,0,0,),
//                 child: Row(
//                   children: [
//                     Text('나의 여행지',
//                       style: TextStyle(fontSize: width * 0.058, fontWeight: FontWeight.w900),
//                     ),
//                     SizedBox(width: width * 0.55),
//                     IconButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('편집 누름')),
//                         );},
//                       icon: Icon(Icons.edit, color: Color(0xFFD3351E),),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: height * 0.012),
//               ...places.map((e) {
//                 final p = e['place'] as Map<String, dynamic>;
//                 return PlaceInfo(
//                   name: p['name']?.toString() ?? '',
//                   road_address: p['road_address']?.toString() ?? '',
//                   address: p['address']?.toString() ?? '',
//                   imageURL: '', //지금 api에 없어서 일단 빈칸으로
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
