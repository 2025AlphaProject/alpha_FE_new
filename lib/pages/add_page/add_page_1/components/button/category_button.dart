import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"name": "관광지", "icon": Icons.map_outlined},
    {"name": "문화시설", "icon": Icons.account_balance},
    {"name": "축제/공연/행사", "icon": Icons.theater_comedy},
    {"name": "레포츠", "icon": Icons.sports_kabaddi},
    {"name": "숙박", "icon": Icons.hotel},
    {"name": "쇼핑", "icon": Icons.shopping_cart},
    {"name": "음식점", "icon": Icons.restaurant},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CategoryButtonItem(
              icon: category['icon'],
              label: category['name'],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryButtonItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryButtonItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPageController>();
    return Obx(() {
      final isSelected = controller.isSelected(label);

      return GestureDetector(
        onTap: () => controller.toggleCategory(label),
        child: SizedBox(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : const Color(0xFFE4E4E4),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(icon, size: 40),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    });
  }
}