
import 'package:conever/pages/plan_page/near_event_page/near_event_page_view.dart';
import 'package:flutter/material.dart';


class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EvnetsState();
}

class _EvnetsState extends State<Events> {
  bool _isExpanded = false;
  List<Map<String, String>> events = [
  {
  'title': '태근태근',
  'img_url': 'https://via.placeholder.com/50',
  'start_date': '2024-07-01',
  'end_date': '2024-07-02',
  },
  {
  'title': 'Event 2',
  'img_url': 'https://via.placeholder.com/50',
  'start_date': '2024-07-05',
  'end_date': '2024-07-06',
  },
  {
  'title': 'Event 3',
  'img_url': 'https://via.placeholder.com/50',
  'start_date': '2024-07-10',
  'end_date': '2024-07-12',
  },
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              Icon(
                  _isExpanded ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 10
              ),
              SizedBox(width: 10),
              Text(
                _isExpanded ? "주변 행사 닫기" : "주변 행사 보기",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: events.isEmpty
              ? Row( //주변행사가 없을때
                  children: [
                    SizedBox(width: 50),
                    const Text(
                      "주변 행사가 없습니다.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5,
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: events.map((event) {
                return Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventInfo(), //연결테스트
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Color(0xFFD3315E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          event['title'] ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                            color: Color(0xFFD3315E)
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          secondChild: const SizedBox.shrink(),
        )
      ],
    );
  }
}
