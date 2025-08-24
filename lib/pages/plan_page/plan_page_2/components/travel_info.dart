import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/controllers/plan_page_controller.dart';

import '../../plan_page_1/components/d_day.dart';
import '../../add_user_page/add_user_page_view.dart';

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.06, width *0.0125, height * 0.025),
      decoration: const BoxDecoration(
        color: Color(0xFFD3351E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Dday(date: date),
              SizedBox(width: width * 0.0116),
              Text(
                date,
                style: TextStyle(fontSize: width * 0.034, color: Colors.white),
              ),
              SizedBox(width: width * 0.47),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close, color: Color(0xFFFFFFFF),),
              )
            ],
          ),
          SizedBox(height: height * 0.005),
          Row(
            children: [
              SizedBox(width: width * 0.011),
              Text(
                title,
                style: TextStyle(fontSize: width * 0.081, fontWeight: FontWeight.w900, color: Colors.white),
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(width * 0.0116),
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
                        radius: width *0.058,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        traveler['username'] ?? '',
                        style: TextStyle(fontSize: width *0.027, color: Colors.white),
                      ),
                    ],
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Get.to(() => addUser());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('초대버튼 누름')),
                    );},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xaaFFFFFF),
                        child: Icon(Icons.add, color: Color(0xFFD3351E), size: width * 0.048),
                      ),
                      SizedBox(height: height *0.005),
                      SizedBox(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "초대",
                            style: TextStyle(fontSize: width * 0.027,color: Colors.white),
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
