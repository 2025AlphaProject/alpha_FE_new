import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';
import 'image_detail.dart';

class PhotoDisplay extends StatelessWidget {
  const PhotoDisplay({super.key});

  final List<String> imagePaths = const [
    'assets/dummy/dummy_image1.png',
    'assets/dummy/dummy_image2.png',
    'assets/dummy/dummy_image3.png',
    'assets/dummy/dummy_image4.png',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyPageController>();

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final path = imagePaths[index];

          return Obx(() {
            final selecting = controller.isSelectingFrame.value;
            final selected = controller.selectedPaths.contains(path);

            return GestureDetector(
              onTap: () {
                if (selecting) {
                  controller.toggleSelect(path);
                } else {
                  showImageDetail(context, imagePaths, index);
                }
              },
              child: Stack(
                children: [
                  Hero(
                    tag: path,
                    child: ClipRRect(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(path, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  if (selecting)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: customCheckBox(selected),
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

Widget customCheckBox(bool selected) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: selected ? const Color(0xFFD3351E) : Colors.transparent,
      border: Border.all(
        color: selected ? const Color(0xFFD3351E) : Colors.white,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: selected
        ? Icon(
      Icons.check,
      size: 16,
      color: Colors.white,
    )
        : null,
  );
}