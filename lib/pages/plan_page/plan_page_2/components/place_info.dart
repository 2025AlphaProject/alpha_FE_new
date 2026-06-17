import 'package:conever/helper/tour/category/category_match.dart';
import 'package:conever/pages/plan_page/near_place_page/near_place_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/controllers/plan_page_controller.dart';

import 'edit_menu/edit_function.dart';

class PlaceInfo extends StatelessWidget {
  final int place_id;
  final String name;
  final String road_address;
  final String address;
  final String imageURL;
  final String placeCategory;
  const PlaceInfo({
    Key? key,
    required this.place_id,
    required this.name,
    required this.road_address,
    required this.address,
    required this.imageURL,
    required this.placeCategory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.find<PlanPageController>();
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.023,
        height * 0.005,
        width * 0.011,
        height * 0.005,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                //여행 장소 이미지
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageURL,
                  width: width * 0.3624,
                  height: height * 0.15,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: width * 0.3624,
                        height: height * 0.15,
                        color: Color(0xFFeda696),
                        child: Image.asset(
                          'assets/icons/logo_white.png',
                          width: width * 0.05,
                          height: height * 0.025,
                        ),
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  width * 0.023,
                  height * 0.005,
                  width * 0.011,
                  0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: width * 0.01,
                      children: [
                        Icon(
                          placeCat(placeCategory),
                          size: width * 0.052,
                          color: Color(0xFFD3351E),
                        ),
                        Container(
                          width: width * 0.47,
                          child: Text(
                            name.replaceAll(RegExp(r'[<>]'), ''),
                            style: TextStyle(
                              fontSize: width * 0.038,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.005),
                    Wrap(
                      //도로명
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          //도로명 설명
                          alignment: Alignment.center,
                          width: width * 0.104,
                          height: height * 0.025,
                          padding: EdgeInsets.all(width * 0.011),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            "도로명",
                            style: TextStyle(
                              fontSize: width * 0.02,

                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.016),
                        SizedBox(
                          //도로명 데이터
                          width: width * 0.43,
                          child: Text(
                            road_address.replaceAll(RegExp(r'[<>]'), ''),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: width * 0.033),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.005),
                    Wrap(
                      //지번
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          //지번 설명
                          alignment: Alignment.center,
                          width: width * 0.104,
                          height: height * 0.025,
                          padding: EdgeInsets.all(width * 0.011),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            "지번",
                            style: TextStyle(fontSize: width * 0.02),
                          ),
                        ),
                        SizedBox(width: width * 0.016),
                        SizedBox(
                          //지번 데이터
                          width: width * 0.43,
                          child: Text(
                            address.replaceAll(RegExp(r'[<>]'), ''),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: width * 0.033),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Obx(() => Visibility(
                          visible: !controller.isEditMode.value,
                          child: TextButton(
                              onPressed: () async {
                                final response = await controller.loadRelatedPlaces(name);
                                if(response == true){
                                  Get.to(NearPlacePageView());
                                }
                              },
                              child: Text("함께 가기 좋은 곳 →", style: TextStyle(color: Color(0xCCD3351E),fontSize: width * 0.03),)
                          ),
                        ),
                        ),
                        Obx(() => Visibility(
                          visible: controller.isEditMode.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: width*0.37,),
                              TextButton(
                                child: Text("삭제", style: TextStyle(color: Color(0xCCD3351E),fontSize: width * 0.03),),
                                onPressed: () {
                                  EditFunction().deletePlace(
                                    context,
                                    name,
                                    place_id,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }
}

IconData? placeCat(String place_cat) {
  if (categoryIcons.containsKey(place_cat)) return categoryIcons[place_cat];
  return Icons.place; // 기본 아이콘
}
