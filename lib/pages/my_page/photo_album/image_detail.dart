import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showImageDetail(
    BuildContext context,
    List<String> paths,
    int initialIndex,
    ) {
  final pageController = PageController(initialPage: initialIndex);

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

        PageView.builder(
          controller: pageController,
          itemCount: paths.length,
          itemBuilder: (context, index) {
            final path = paths[index];
            return Center(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: InteractiveViewer(
                  panEnabled: false,
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Hero(
                    tag: 'gallery-$index-$path',
                    child: Image.asset(
                      path,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

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
                        ), onPressed: () {
                          // TODO: 삭제 로직 구현
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