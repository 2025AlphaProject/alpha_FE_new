import 'package:flutter/material.dart';

import 'components/sort_by_button.dart';
import 'components/plan_card.dart';
import 'components/plan_indicator.dart';

class PlanPage1 extends StatefulWidget {
  const PlanPage1({super.key});

  @override
  State<PlanPage1> createState() => _PlanPage1State();
}

class _PlanPage1State extends State<PlanPage1> {
  late final PageController _pageController;
  List<Map<String, dynamic>> _cards = [];

  DateTime _parseDate(String s) {
    final norm = s.contains('.') ? s.replaceAll('.', '-') : s;
    return DateTime.parse(norm);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _cards = [
      {'title': '성북구 산책','date': '2025.08.16','tour_id': 1},
      {'title': '부산 바다','date': '2024.09.01','tour_id': 2},
      {'title': '제주 올레','date': '2025.10.12','tour_id': 3},
    ];
    _cards.sort((a,b) => _parseDate(a['date']).compareTo(_parseDate(b['date'])));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool planOk = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Row(
              children: [
                Icon(
                  Icons.airplanemode_active,
                  color:Color(0xFFD3351E),
                ),
                SizedBox(width:15),
                Text(
                  "나의 여행지",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(height: 47),
            SortByButton(
              onSorted: (sorted) {
                setState(() {
                  _cards = sorted;
                  if (_cards.isNotEmpty && _pageController.hasClients) {
                    _pageController.jumpToPage(0);
                  }
                });
              },
            ),
            SizedBox(height: 21),
            SizedBox(
              height: 400,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final item = _cards[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: PlanCard(
                      title: item['title']!,
                      date: item['date']!,
                      size_h: 200,
                      size_w: 150,
                      tour_id: item['tour_id'],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            // 페이지 인디케이터
            PlanIndicator(
              controller: _pageController,
              count: _cards.length,
              dotSize: width * 0.02,
              dotActiveWidth: width * 0.03,)
          ],
        ),
      )
    );
  }
}
