import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'near_place_category.dart';
import 'detail_near_place.dart';

class NearPlaceInfo extends StatefulWidget {
  final Map<String, dynamic> nearPlaceInfo;
  const NearPlaceInfo({super.key, required this.nearPlaceInfo});

  @override
  State<NearPlaceInfo> createState() => _NearPlaceInfoState();
}

class _NearPlaceInfoState extends State<NearPlaceInfo> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final String cat1 = widget.nearPlaceInfo["related_place_cat1_name"];
    final String cat2 = widget.nearPlaceInfo["related_place_cat2_name"];
    final String cat3 = widget.nearPlaceInfo["related_place_cat3_name"];
    final detailInfo = widget.nearPlaceInfo["related_place_detail_info"];

    return Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFFD3351E),
                  child: Icon(placeCategory(cat1, cat2, cat3),
                      color: Colors.white, size: width * 0.06),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                  width: width * 0.67,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nearPlaceInfo["related_place_name"],
                        style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.008),
                      Text(
                        "${widget.nearPlaceInfo["related_place_area_name"]} ${widget.nearPlaceInfo["related_place_sigungu_name"]} | ${widget.nearPlaceInfo["related_place_cat2_name"]}",
                        style: TextStyle(fontSize: width * 0.032),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: detailInfo != null,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    icon: Icon(
                      _expanded ? Icons.expand_less :Icons.expand_more,
                        color: Color(0xFFD3351E), size: width * 0.05),
                  ),
                )
              ],
            ),
          ),
          if (_expanded && detailInfo != null)
            detailNearPlace(
              detailInfo: detailInfo,
              width: width,
              height: height,
              cat1: cat1,
              cat2: cat2,
              cat3: cat3,
            ),
        ],
      ),
    );
  }
}

