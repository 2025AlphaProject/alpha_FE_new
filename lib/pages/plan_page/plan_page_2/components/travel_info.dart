import 'package:flutter/material.dart';

import '../../plan_page_1/components/d_day.dart';

class TravelInfo extends StatelessWidget {
  final String date;
  final String title;
  final List<dynamic> travelers;

  const TravelInfo({
    Key? key,
    required this.date,
    required this.title,
    required this.travelers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(20,50,5,20),
      decoration: const BoxDecoration(
        color: Color(0xFFD3351E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Dday(date: date),
              SizedBox(width: 5),
              Text(
                date,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(width: 170,),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Color(0xFFFFFFFF),),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ],
          ),
          Travelers(travelers: travelers)
        ],
      ),
    );
  }
}

class Travelers extends StatelessWidget {
  final List<dynamic> travelers;

  const Travelers({super.key, required this.travelers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Wrap(
              spacing: 17,
              runSpacing: 8,
              children: [
                ...travelers.map((traveler) {
                  final imageUrl = traveler['profile_image_url'] ?? '';
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        traveler['username'] ?? '',
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  );
                }),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('초대버튼 누름')),
                    );},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xaaFFFFFF),
                        child: Icon(Icons.add, color: Color(0xFFD3351E), size: 21),
                      ),
                      SizedBox(height: 5),
                      const SizedBox(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "초대",
                            style: TextStyle(fontSize: 12,color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
