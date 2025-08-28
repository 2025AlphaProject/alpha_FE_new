import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';
import 'photo_display_loading_page.dart';

class PhotoAlbum extends StatelessWidget {
  const PhotoAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyPageController>();
    final width = MediaQuery.of(context).size.width;

    return Obx(() => Padding(
      padding: const EdgeInsets.fromLTRB(29, 63, 28, 0),
      child: controller.groupedUserTour.isEmpty
          ? const Center(child: Text(
        "추가된 여행이 없습니다!\n여행을 추가해주세요!",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ))
          : ListView(
        children: controller.groupedUserTour.entries.map((entry) {
          final year = entry.key;
          final tours = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$year년',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 26),
              ...tours.map((tour) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () {
                    controller.selectedTourId.value = tour['id'];
                    controller.selectedTourName.value = tour['tour_name'];
                    controller.selectedTourDate.value = tour['tour_date'];
                    controller.selectedTourArea.value = tour['area_info'];
                    Get.to(() => PhotoDisplayLoadingPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          tour['thumbnail'] != null
                              ? CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(tour['thumbnail']!) as ImageProvider,
                          ) : Image.asset(
                            'assets/icons/missing_image_icon.png',
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tour['tour_name'] ?? '제목 없음',
                                    style: TextStyle(
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${tour['tour_date']} | ${tour['area_info']}",
                                    style: TextStyle(
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ))
            ],
          );
        }).toList(),
      ),
    ));
  }
}