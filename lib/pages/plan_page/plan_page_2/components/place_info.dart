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
    return Container(
      padding: EdgeInsets.fromLTRB(10,5,5,5),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect( //여행 장소 이미지
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageURL,
                  width: 130,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 130,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 22.6),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row( //장소명
                      children: [
                        Icon(Icons.place,size:22.6, color: Color(0xFFD3351E),),
                        SizedBox(width: 2),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              name.replaceAll(RegExp(r'[<>]'), ''),
                              style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),

                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Wrap( //도로명
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container( //도로명 설명
                          alignment: Alignment.center,
                          width: 45,
                          height: 25,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: const Text("도로명", style: TextStyle(fontSize: 12)),
                        ),
                        SizedBox(width: 7),
                        SizedBox( //도로명 데이터
                          width: 170,
                          child: Text(
                            road_address.replaceAll(RegExp(r'[<>]'), ''),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 14.3),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Wrap( //지번
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container( //지번 설명
                          alignment: Alignment.center,
                          width: 45,
                          height: 25,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: const Text("지번", style: TextStyle(fontSize: 12)),
                        ),
                        SizedBox(width: 7),
                        SizedBox( //지번 데이터
                          width: 170,
                          child: Text(
                            address.replaceAll(RegExp(r'[<>]'), ''),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 14.3),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              )
            ],
          ),
          SizedBox(height: 5,),
          Events(),
        ],
      ),
    );
  }
}
