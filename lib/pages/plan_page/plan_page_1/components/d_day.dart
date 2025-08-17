import 'package:flutter/material.dart';

class Dday extends StatelessWidget {
  final String date;

  const Dday({
    Key? key,
    required this.date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final d_day = getDday(date); //계산된 D-day
    return Card(
      color: Color(0xFFD3351E),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2)
      ),
      margin: EdgeInsets.symmetric(vertical: height * .006, horizontal:  width * .013),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.0015,
        ),
        child: Text(
          d_day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//D-day 계산
String getDday(String date){
  final today = DateTime.now();
  final travelDate = DateTime.parse(date.replaceAll('.','-'));

  if (today.isAfter(travelDate.add(Duration(days: 1)))) return '종료';
  if (!today.isBefore(travelDate)) return 'D-day';

  final todayDate = DateTime(today.year, today.month, today.day);
  final DateOnly = DateTime(travelDate.year, travelDate.month, travelDate.day);
  final remaining = DateOnly.difference(todayDate).inDays;
  return 'D-$remaining';

}