import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';
import '../create_inseng_4_cut/create_inseng_4_cut_loading.dart';
import 'photo_display.dart';

class PhotoAlbumDetailPage extends StatelessWidget {
  const PhotoAlbumDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyPageController>();

    final tourDate = DateTime.parse(controller.selectedTourDate.value);
    final isPast = DateTime.now().difference(tourDate).inDays > 3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      controller.selectedTourName.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      controller.selectedTourArea.value,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Text(
                    controller.selectedTourDate.value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 53.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '보관중인 사진',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Obx(() => Text(
                                '${controller.userDetailTourImage.length}장',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey[500]
                                ),
                              )),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.toggleIsSelectingFrame();
                            },
                            child: Obx(() => Text(
                              controller.isSelectingFrame.value
                               ? '취소' : '+ 네컷 생성',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFFD3351E)
                              ),
                            ))
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                thickness: 2,
                color: Colors.black,
              ),
            ),
            PhotoDisplay(),
          ],
        ),
      bottomNavigationBar: Obx(() => controller.isSelectingFrame.value
      ? Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: SizedBox(
          height: 60,
          child: Obx(() => ElevatedButton(
              onPressed: () {
                if (controller.selectedPaths.length == 4) {
                  Get.to(() => CreateInseng4CutLoading());
                } else {
                  Get.snackbar(
                      '프레임 생성 실패',
                      '사진을 4장 골라주세요!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: controller.selectedPaths.length == 4 ? Color(0xFFD3351E) : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
              ),
              child: Text(
                '프레임 생성하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
          ))
        ),
      )
      : Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              elevation: 5,
              shape: const CircleBorder(),
              shadowColor: Colors.grey,
              child: GestureDetector(
                onTap: () {
                  if (isPast) {
                    Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            "사진 저장 불가",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          content: const Text(
                            "사진은 여행 후 3일 까지만\n업로드 가능합니다!",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                    );
                  } else {
                    controller.pickAndUploadImage();
                  }
                },
                child: CircleAvatar(
                  backgroundColor: isPast ? Color(0xFFDBDBDB) : Color(0xFFFF6C57),
                  radius: 40,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ))
    );
  }
}
