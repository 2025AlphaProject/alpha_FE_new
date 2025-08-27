// TODO: 이미지 삭제 시 인생네컷인지 아닌지 알 수 있는 단자 추가 필요

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';

void showImageDetail(
    BuildContext context,
    List<String> paths,
    int initialIndex,
    bool isFourCut,
    ) {
  final pageController = PageController(initialPage: initialIndex);
  final controller = Get.find<MyPageController>();
  Get.dialog(
    Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(color: Colors.black.withOpacity(0.25)),
            ),
          ),
        ),

        Obx(() => PageView.builder(
          controller: pageController,
          itemCount: paths.length,
          itemBuilder: (context, index) {
            final path = paths[index];
            controller.selectedImagePath.value = path;
            return Center(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: InteractiveViewer(
                  panEnabled: false,
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Hero(
                    tag: 'gallery-$index-$path',
                    child: Image.network(
                      path,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            );
          },
        )),

        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.delete_forever_outlined, color: Colors.white),
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
                          Get.back();
                          Get.back();
                          isFourCut ? await controller.deleteFourCut() : controller.deleteImage();
                    }, child: Text('확인')),
                  ],
                )
              );
            },
          ),
        ),
      ],
    ),
    barrierDismissible: true,
    barrierColor: Colors.transparent,
  );
}