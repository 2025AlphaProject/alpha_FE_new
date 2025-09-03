import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:conever/controllers/plan_page_controller.dart';
import 'package:conever/components/bottom_navigation_bar/app_shell.dart';
import 'package:conever/controllers/bottom_navigation_controller.dart';



void showDateEditBottomSheet(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final controller = Get.find<PlanPageController>();
  DateTime _focusedDay = controller.selectedDay.value; //둘다 여행날짜로
  DateTime? _selectedDay = controller.selectedDay.value;
  DateTime earlierDate = _selectedDay.isBefore(DateTime.now())
      ? _selectedDay
      : DateTime.now();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: width *0.037, right: width *0.037, top: height *0.025,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("여행 날짜 수정", style: TextStyle(fontSize: width *0.041, fontWeight: FontWeight.bold)),
                SizedBox(height: height * 0.017),
                TableCalendar(
                  firstDay: earlierDate,
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      _selectedDay = selected;
                      _focusedDay = focused;
                    });
                  },
                  headerStyle: HeaderStyle(formatButtonVisible: false),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),//선택한 날짜
                    todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle), // 오늘 날짜
                    selectedTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: height *0.016),
                Padding(
                  padding: EdgeInsets.fromLTRB(width *0.02, 0, width *0.02, height * 0.01),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.02,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,color: Color(0xccD3351E),),
                          SizedBox(width: width * 0.02,),
                          Container(
                            width: width *0.6,
                            child: Text(DateFormat('yyyy.MM.dd').format(_selectedDay!),
                              style: TextStyle(
                                fontSize: width *0.046,
                                color: Color(0xccD3351E)
                              ),
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.dialog(
                              AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text("여행 날짜 수정",style: TextStyle(fontSize: width*0.05,color: Color(0xccD3351E)),),
                                content: Text("'${DateFormat('yyyy.MM.dd').format(_selectedDay!)}'로 수정하시겠습니까?",style: TextStyle(fontSize: width*0.04),),
                                actions: [
                                  TextButton( //날짜 수정 취소 버튼
                                      onPressed: (){Get.back();},
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xfff6d1ca)
                                      ),
                                      child: Text("취소",style: TextStyle(color:Color(0xffD3351E)))
                                  ),
                                  TextButton( //날짜 수정 버튼
                                      onPressed: () async {
                                        final editDate = DateFormat('yyyy-MM-dd').format(_selectedDay!).toString();
                                        final response = await controller.editDate(controller.course['id'], editDate);
                                        if(response){
                                          controller.tourCourse(controller.course['id']);
                                          Get.back();
                                        }

                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xffD3351E)
                                      ),
                                      child: Text("수정",style: TextStyle(color: Colors.white),)
                                  )
                                ],
                          ));
                        },
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xfff6d1ca)
                          ),
                          child: Text("수정",style: TextStyle(color: Color(0xffD3351E)),)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height *0.017),
              ],
            );
          },
        ),
      );
    },
  );
}