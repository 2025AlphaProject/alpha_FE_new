import 'package:conever/pages/plan_page/plan_page_2/components/place_info.dart';
import 'package:conever/pages/plan_page/plan_page_2/components/travel_info.dart';
import 'package:flutter/material.dart';


class PlanPage2 extends StatefulWidget {
  const PlanPage2({super.key});

  @override
  State<PlanPage2> createState() => _PlanPage2State();
}

class _PlanPage2State extends State<PlanPage2> {
  final Map<String, dynamic> _trip = {
    "id": 1,
    "tour_name": "태근이의 여행",
    "tour_date": "2025-07-07",
    "user": [
      {
        "sub": 3928446869,
        "username": "TestUser",
        "profile_image_url": "https://avatars.githubusercontent.com/u/46028234?v=4"
      },
      {
        "sub": 3928446869,
        "username": "임태근",
        "profile_image_url": "https://avatars.githubusercontent.com/u/46028234?v=4"
      }
    ],
    "places": [
      {
        "tdp_id": 1,
        "place": {
          "id": 8,
          "name": "명원박물관",
          "mapX": 126.9999927956,
          "mapY": 37.6111883307,
          "road_address": "테스트지롱",
          "address": "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ",
          "contentid": "12"
        }
      },
      {
        "tdp_id": 2,
        "place": {
          "id": 9,
          "name": "아산 공세리성당",
          "mapX": 126.9134070332,
          "mapY": 36.8833377411,
          "road_address": "충청남도 아산시 인주면 공세리성당길 10",
          "address": "충청남도 아산시 인주면 공세리성당길 10",
          "contentid": "None"
        }
      },
      {
        "tdp_id": 3,
        "place": {
          "id": 10,
          "name": "성북구립미술관",
          "mapX": 126.9949020554,
          "mapY": 37.594890134,
          "road_address": "서울특별시 성북구 성북로 134 (성북동)",
          "address": "서울특별시 성북구 성북로 134",
          "contentid": "None"
        }
      },{
        "tdp_id": 1,
        "place": {
          "id": 8,
          "name": "명원박물관",
          "mapX": 126.9999927956,
          "mapY": 37.6111883307,
          "road_address": "테스트지롱",
          "address": "",
          "contentid": "12"
        }
      },
      {
        "tdp_id": 2,
        "place": {
          "id": 9,
          "name": "아산 공세리성당",
          "mapX": 126.9134070332,
          "mapY": 36.8833377411,
          "road_address": "충청남도 아산시 인주면 공세리성당길 10",
          "address": "충청남도 아산시 인주면 공세리성당길 10",
          "contentid": "None"
        }
      },
      {
        "tdp_id": 3,
        "place": {
          "id": 10,
          "name": "성북구립미술관",
          "mapX": 126.9949020554,
          "mapY": 37.594890134,
          "road_address": "서울특별시 성북구 성북로 134 (성북동)",
          "address": "서울특별시 성북구 성북로 134",
          "contentid": "None"
        }
      },{
        "tdp_id": 1,
        "place": {
          "id": 8,
          "name": "명원박물관",
          "mapX": 126.9999927956,
          "mapY": 37.6111883307,
          "road_address": "테스트지롱",
          "address": "",
          "contentid": "12"
        }
      },
      {
        "tdp_id": 2,
        "place": {
          "id": 9,
          "name": "아산 공세리성당",
          "mapX": 126.9134070332,
          "mapY": 36.8833377411,
          "road_address": "충청남도 아산시 인주면 공세리성당길 10",
          "address": "충청남도 아산시 인주면 공세리성당길 10",
          "contentid": "None"
        }
      },
      {
        "tdp_id": 3,
        "place": {
          "id": 10,
          "name": "성북구립미술관",
          "mapX": 126.9949020554,
          "mapY": 37.594890134,
          "road_address": "서울특별시 성북구 성북로 134 (성북동)",
          "address": "서울특별시 성북구 성북로 134",
          "contentid": "None"
        }
      }
    ]
  };
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final String title = _trip['tour_name'] as String;
    final String date = (_trip['tour_date'] as String).replaceAll('-', '.');
    final List<dynamic> places = _trip['places'] as List<dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TravelInfo(date: date, title: title, travelers:_trip['user'] as List<dynamic>),
              Container(
                padding: EdgeInsets.fromLTRB(width * 0.034,height*0.01,0,0,),
                child: Row(
                  children: [
                    Text('나의 여행지',
                      style: TextStyle(fontSize: width * 0.058, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(width: width * 0.55),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('편집 누름')),
                        );},
                      icon: Icon(Icons.edit, color: Color(0xFFD3351E),),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.012),
              ...places.map((e) {
                final p = e['place'] as Map<String, dynamic>;
                return PlaceInfo(
                  name: p['name']?.toString() ?? '',
                  road_address: p['road_address']?.toString() ?? '',
                  address: p['address']?.toString() ?? '',
                  imageURL: '', //지금 api에 없어서 일단 빈칸으로
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
