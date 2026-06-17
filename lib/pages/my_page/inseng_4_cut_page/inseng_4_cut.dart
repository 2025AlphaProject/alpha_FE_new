import 'package:conever/controllers/my_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../photo_album/image_detail.dart';

class Inseng4Cut extends StatefulWidget {
  const Inseng4Cut({super.key});

  @override
  State<Inseng4Cut> createState() => _Inseng4CutState();
}

class _Inseng4CutState extends State<Inseng4Cut> {
  final controller = Get.find<MyPageController>();

  @override
  void initState() {
    super.initState();
    controller.getFourCutImages();
    controller.fetchUsername();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 43.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Obx(() => Text(
                  '${controller.username.value}님의 아카이브',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                )),
                const SizedBox(width: 6),
                Text(
                  '${controller.userFourCutImage.length}장',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 38),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemCount: controller.userFourCutImage.length,
              itemBuilder: (context, index) {
                final path = controller.userFourCutImage[index];
                return GestureDetector(
                  onTap: () {
                    showImageDetail(context, controller.userFourCutImage, index, true);
                  },
                  child: Hero(
                    tag: path,
                    child: ClipRRect(
                      child: Image.network(
                        path,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const ColoredBox(
                          color: Colors.black12,
                          child: Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}