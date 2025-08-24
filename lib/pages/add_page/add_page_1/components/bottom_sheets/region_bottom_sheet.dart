import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';

class RegionBottomSheet extends StatelessWidget {
  const RegionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (_, scrollController) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              '지역 선택',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Obx(() => Expanded(
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: controller.sidoListName.value.length,
                itemBuilder: (context, index) {
                  final regionName = controller.sidoListName.value[index];
                  // final regionImage = controller.sidoListAndImage.value[index];

                  return GestureDetector(
                    onTap: () {
                      controller.selectedBigPlace.value = regionName;
                      controller.fetchAreaList();
                      Get.back();
                    },
                    child: RegionCard(
                      name: regionName,
                      imagePath: 'http://tong.visitkorea.or.kr/cms/resource/58/3402758_image2_1.jpg',
                    ),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class RegionCard extends StatelessWidget {
  final String name;
  final String imagePath;

  const RegionCard({super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.all(12),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 2, color: Colors.black)],
        ),
      ),
    );
  }
}