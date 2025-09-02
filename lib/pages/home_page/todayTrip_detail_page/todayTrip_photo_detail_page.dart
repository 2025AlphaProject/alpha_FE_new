import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../../controllers/home_page_controller.dart';
import '../../../services/http/tour/delete_tour_image.dart';

class todayTripPhotoDetailPage extends StatelessWidget {
  final String imageUrl;
  final int imageId;

  const todayTripPhotoDetailPage({super.key, required this.imageUrl, required this.imageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //     child: Container(
          //       color: Colors.black.withOpacity(0.7),
          //     ),
          //   ),
          // ),
          Center(
            child: InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text(
                    '이미지 로딩 오류',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.02,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
            child: IconButton(
              icon: Icon(Icons.delete_forever_outlined, color: Colors.white),
              onPressed: () {
                Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        '사진 삭제',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      content: Text('사진을 삭제하시겠습니까?'),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                )
                            ), onPressed: () => Get.back(), child: Text('취소')),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFD3351E),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                )
                            ), onPressed: () async {
                          await deleteTourImage(imageId);
                          Get.find<HomePageController>().loadTourImages(Get.find<HomePageController>().tourId.value);
                          Get.close(2);
                        }, child: Text('확인')),
                      ],
                    )
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}
