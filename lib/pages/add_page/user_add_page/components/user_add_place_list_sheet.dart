import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/user_add_page_controller.dart';
import 'user_add_place_list_tile.dart';

class UserAddPlaceListSheet extends StatelessWidget {
  const UserAddPlaceListSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserAddPageController>();

    // 반응형 크기 계산

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (kIsWeb) width = 430;

    return Container(
      // 투명 배경과 별도 둥근 상단 컨테이너

      decoration: const BoxDecoration(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.25,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(width * 0.06),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: width * 0.035,
            ),
            child: Obx(
              () => Column(
                children: [
                  // 핸들바

                  Container(
                    width: width * 0.16,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),

                  controller.addedPlaces.length != 0
                  ? Column(
                    children: [
                      SizedBox(height: height * 0.017),
                      Text(
                          '${controller.addedPlaces.length}개의 장소 추가됨',
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                    ],
                  )
                  : SizedBox(height: height * 0.0443),


                  SizedBox(height: width * 0.04),

                  // 목록

                  Expanded(
                    child: Obx(
                          () => ListView.separated(
                        controller: scrollController,
                        itemCount: controller.places.length,
                        separatorBuilder: (_, __) => Divider(
                          height: width * 0.03,
                          thickness: 0.7,
                          color: Colors.grey.shade200,
                        ),
                        itemBuilder: (_, idx) {
                          final doc = controller.places[idx];
                          return UserAddPlaceListTile(doc: doc);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}