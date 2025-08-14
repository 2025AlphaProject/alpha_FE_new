import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../controllers/add_page_controller.dart';

class SelectDateContainer extends StatelessWidget {
  const SelectDateContainer({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    return ExpandableNotifier(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 80,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(0, 3)
              )
            ]
        ),
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            hasIcon: false,
            tapBodyToExpand: true,
            tapHeaderToExpand: true,
            tapBodyToCollapse: true,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '여행 날짜',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 30,
                    ),
                  ],
                ),
                Obx(() =>
                    Text(
                      DateFormat('yyyy/MM/dd').format(controller.selectedDay.value),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey
                      ),
                    ),
                )
              ],
            ),
          ),
          expanded: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Obx(() =>
                    TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: controller.focusedDay.value,
                      selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),
                      onDaySelected: controller.onDaySelected,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                    )
                )
              ],
            ),
          ),
          collapsed: SizedBox.shrink(),
        ),
      ),
    );
  }
}