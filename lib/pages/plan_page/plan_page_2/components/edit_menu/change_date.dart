// 여행 날짜를 변경할 수 있는 바텀시트를 표시하는 함수
// StatefulBuilder를 사용하여 내부 상태(selectedDay, focusedDay)를 관리함
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter/material.dart';

// 날짜 편집 바텀시트를 화면에 표시하는 함수
// isScrollControlled: true → 키보드가 올라와도 전체를 스크롤할 수 있게 함
// shape → 상단 모서리를 둥글게 만듦
void showDateEditBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      // 하단에 키보드가 올라올 경우를 대비한 패딩 설정
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 바텀시트 제목 텍스트
            Text("여행 날짜 수정", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 16),

            // 날짜 선택 캘린더를 표시하고 내부 상태(selectedDay, focusedDay)를 갱신
            StatefulBuilder(
              builder: (context, setState) {
                // 캘린더에서 현재 보고 있는 달
                DateTime focusedDay = DateTime.now();
                // 사용자가 선택한 날짜
                DateTime? selectedDay;

                // 날짜 선택 UI를 위한 캘린더 위젯
                return TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  // 선택된 날짜와 동일한 날짜에만 선택 스타일 적용
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  // 날짜를 선택했을 때 선택일과 포커스일 업데이트
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDay = selected;
                      focusedDay = focused;
                    });
                  },
                  headerStyle: HeaderStyle(formatButtonVisible: false),
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
                );
              },
            ),

            SizedBox(height: 24),

            // 확인 버튼을 눌렀을 때 바텀시트를 닫음
            // 실제 선택한 날짜를 외부로 전달하지는 않음 (컨트롤러가 없기 때문)
            ElevatedButton(
              onPressed: () {
                // 날짜 선택 완료 처리
                Navigator.pop(context);
              },
              child: Text("확인"),
            ),

            SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}