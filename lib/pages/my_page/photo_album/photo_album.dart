import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photo_album_detail_page.dart';

class PhotoAlbum extends StatelessWidget {
  const PhotoAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(29, 63, 28, 0),
      // TODO: 데이터 받고 리스트 형태로 전환
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '2025년',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => PhotoAlbumDetailPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/dummy/dummy_image1.png'),
                  ),
                  Column(
                    // TODO: 반응형
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "8월 충남 아산 여행",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ), // 0.0384
                      Text(
                          "2025년 8월 1일 | 충청남도 아산시",
                        style: TextStyle(
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Icon(
                      Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
