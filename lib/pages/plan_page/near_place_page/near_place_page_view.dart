import 'package:conever/pages/plan_page/near_place_page/components/near_place_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/plan_page_controller.dart';

class NearPlacePageView extends StatefulWidget {
  const NearPlacePageView({super.key});

  @override
  State<NearPlacePageView> createState() => _NearPlacePageViewState();
}

class _NearPlacePageViewState extends State<NearPlacePageView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanPageController>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final relatedPlace = controller.relatedPlaces;
    final List<dynamic> places = relatedPlace["results"] as List<dynamic>? ?? [];

    if (relatedPlace["count"]==0) {
      return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          leading: IconButton(
              onPressed: (){Get.back();},
              icon: Icon(Icons.arrow_back_ios_outlined,color: Color(0xCCD3351E),)
          ),
          title: Text("함께 가기 좋은 곳",style: TextStyle(color:Color(0xCCD3351E) ),),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/map_icon.png',
                width: width * 0.5,
              ),
              SizedBox(height: height * 0.03),
              Text(
                '이 주변의 여행지는 준비 중이에요',
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.1),
            ],
          ),
        )
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(
            onPressed: (){Get.back();},
            icon: Icon(Icons.arrow_back_ios_outlined,color: Color(0xCCD3351E),)
        ),
        title: Text("함께 가기 좋은 곳",style: TextStyle(color:Color(0xCCD3351E) ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.018),
        child:SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ...places.map((e)=> NearPlaceInfo(nearPlaceInfo: e,)).toList(),
            ],
          ),
        )
      ),
    );
  }
}
