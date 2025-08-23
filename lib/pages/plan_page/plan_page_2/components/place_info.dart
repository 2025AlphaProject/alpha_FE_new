import 'package:conever/pages/plan_page/plan_page_2/components/place_event.dart';
import 'package:flutter/material.dart';

class PlaceInfo extends StatelessWidget {
  final String name;
  final String road_address;
  final String address ;
  final String imageURL;
  const PlaceInfo({
    Key? key,
    required this.name,
    required this.road_address,
    required this.address,
    required this.imageURL
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(width * 0.023,height * 0.005,width * 0.011,height *0.005),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect( //여행 장소 이미지
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageURL,
                  width: width * 0.302,
                  height: height * 0.118,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: width * 0.302,
                    height: height * 0.107,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, size: width * 0.052),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(width * 0.023, height * 0.005, width * 0.011, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row( //장소명
                      children: [
                        Icon(Icons.place,size: width * 0.052, color: Color(0xFFD3351E),),
                        SizedBox(width: width * 0.004),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              name.replaceAll(RegExp(r'[<>]'), ''),
                              style: TextStyle(fontSize: width * 0.038, fontWeight: FontWeight.bold),

                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.005),
                    Wrap( //도로명
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container( //도로명 설명
                          alignment: Alignment.center,
                          width: width * 0.104,
                          height: height * 0.025,
                          padding: EdgeInsets.all(width * 0.011),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text("도로명", style: TextStyle(fontSize: width * 0.025)),
                        ),
                        SizedBox(width: width * 0.016),
                        SizedBox( //도로명 데이터
                          width: width * 0.47,
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
                    Wrap( //지번
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container( //지번 설명
                          alignment: Alignment.center,
                          width: width * 0.104,
                          height: height * 0.025,
                          padding: EdgeInsets.all(width * 0.011),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text("지번", style: TextStyle(fontSize: width * 0.025)),
                        ),
                        SizedBox(width: width * 0.016),
                        SizedBox( //지번 데이터
                          width: width * 0.47,
                          child: Text(
                            address.replaceAll(RegExp(r'[<>]'), ''),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: width * 0.033),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              )
            ],
          ),
          SizedBox(height: height * 0.01),
          //Events(), //주변행사였던것
        ],
      ),
    );
  }
}
