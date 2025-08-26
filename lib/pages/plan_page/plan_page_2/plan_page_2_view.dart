import 'package:conever/controllers/plan_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/place_info.dart';
import 'components/travel_info.dart';
import 'components/edit_menu/edit_menu.dart';

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
                      Obx(() => IconButton(
                        icon: Icon( controller.isEditMode.value ? Icons.check : Icons.edit, color: const Color(0xFFD3351E)),
                        onPressed: () {
                          if(controller.isEditMode.value == false){
                            Get.bottomSheet(
                              EditMenuSheet(), // 아래에 정의됨
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                            );
                          } else{
                            controller.isEditMode.value = !controller.isEditMode.value;
                          }
                        },
                      )),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.012),
                ...places.map((e) { //여행 장소들 나타내기
                  final p = e['place'] as Map<String, dynamic>;
                  return PlaceInfo(
                    place_id: p['id'],
                    name: p['name']?.toString() ?? '',
                    road_address: p['road_address']?.toString() ?? '',
                    address: p['address']?.toString() ?? '',
                    imageURL: p['place_image'],
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
