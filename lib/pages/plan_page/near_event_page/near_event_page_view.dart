import 'package:flutter/material.dart';

class EventInfo extends StatelessWidget {
  const EventInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> event = {
      "id": 45,
      "category": "A02",
      "gu_name": "",
      "title": "김해분청도자기 축제",
      "img_url": "http://tong.visitkorea.or.kr/cms/resource/58/3402758_image2_1.jpg",
      "start_date": "2025-11-04",
      "end_date": "2025-11-09",
      "mapX": 128.7459053654,
      "mapY": 35.2517674455,
      "homepage_url": ""
    };
    final double width = 400;
    final double height = 800;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Color(0xFF000000),),
              ),
            ),
            Container(
              child: Text(
                event['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event['img_url'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFD3315E))
              ),
              child: Column(
                children: [
                  _infoRow("유형", "전시/미술"),
                  SizedBox(height: 8),
                  _infoRow("행사 기간", "${event['start_date'].replaceAll('-', '.')} ~ ${event['end_date'].replaceAll('-', '.')}"),
                  SizedBox(height: 8),
                  _infoRow("웹사이트", "웹사이트 보기 →", isLink: true),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _infoRow(String label, String value, {bool isLink = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      Flexible(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: isLink ? Colors.blue : Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}