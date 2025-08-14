import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';

class RegionBottomSheet extends StatelessWidget {
  final List<Map<String, String>> regions = [
    {'name': '서울', 'image': 'assets/seoul.jpg'},
    {'name': '부산', 'image': 'assets/busan.jpg'},
    {'name': '대전', 'image': 'assets/daejeon.jpg'},
    {'name': '울산', 'image': 'assets/ulsan.jpg'},
  ];

  RegionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (_, controller) => Container(
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
            Expanded(
              child: GridView.count(
                controller: controller,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: regions.map((region) {
                  return GestureDetector(
                    onTap: () {
                      final controller = Get.find<AddPageController>();
                      controller.selectedBigPlace.value = region['name']!;
                      Get.back();
                    },
                    child: RegionCard(
                      name: region['name']!,
                      imagePath: region['image']!,
                    ),
                  );
                }).toList(),
              ),
            ),
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
          image: AssetImage(imagePath),
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