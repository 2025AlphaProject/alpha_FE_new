import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'near_place_category.dart';

Widget detailNearPlace({
  required Map<String, dynamic> detailInfo,
  required double width,
  required double height,
  required String cat1,
  required String cat2,
  required String cat3,
}) {
  return Container(
    padding: EdgeInsets.all(width * 0.025),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: detailInfo['place_image'] !=null && detailInfo['place_image']!="",
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  detailInfo['place_image'],
                  width: double.infinity,
                  height: height * 0.25,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    height: height * 0.25,
                    child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                  ),
                )
            ),
        ),
        SizedBox(height: height * 0.02),
        Text( //장소 이름
          detailInfo['name'] ?? '',
          style: TextStyle(fontSize: width * 0.055, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.005),
        Text( //도로명 주소
          detailInfo['road_address'] ?? '',
          style: TextStyle(fontSize: width * 0.037, color: Colors.grey[700]),
        ),
        SizedBox(height: height * 0.015),
        Row( //관광지 카테고리 정보
          children: [
            Icon(placeCategory(cat1, cat2, cat3), color: Color(0xFFD3351E), size: width * 0.05),
            SizedBox(width: width * 0.02),
            Flexible(
              child: Text(
                "${cat1 ?? ''} > ${cat2 ?? ''} > ${cat3 ?? ''}",
                style: TextStyle(fontSize: width * 0.04),
              ),
            )
          ],
        )
      ],
    ),
  );
}

