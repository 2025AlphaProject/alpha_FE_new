import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/add_page_controller.dart';
import '../../../../../helper/tour/category/category_match.dart';

class BuildTourList extends StatefulWidget{
  const BuildTourList({super.key});

  @override
  State<BuildTourList> createState() => _BuildTourListState();
}

class _BuildTourListState extends State<BuildTourList> {
  final controller = Get.find<AddPageController>();

  @override
  Widget build(BuildContext context) {
    final entries = controller.fetchedTour.entries.toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final categoryId = entry.key;
        final items = entry.value as List;
        final categoryName = getCategoryName(categoryId);
        final categoryIcon = getCategoryIcon(categoryId);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Row(
                children: [
                  Icon(categoryIcon, size: 40),
                  const SizedBox(width: 8),
                  Text(
                    categoryName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...items.map<Widget>((item) {
              final String id = '${item['contentId'] ?? ''}';
              return GestureDetector(
                onTap: () {
                  controller.toggleSelect(id);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Obx(() => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: controller.selectedIds.contains(id) ? Colors.blue : Colors.grey,
                          blurRadius: controller.selectedIds.contains(id) ? 12 : 3,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            item['image1'],
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: double.infinity,
                              height: 180,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(categoryIcon, size: 30, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      item['title'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 18, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item['address'] ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  )
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 24.0),
                  child: Obx(() {
                    final count = items.where((it) {
                      final id = '${it['contentId'] ?? ''}';
                      return controller.selectedIds.contains(id);
                    }).length;
                    return Text(
                      '$count/${items.length} 선택됨',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF9A9A9A),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}