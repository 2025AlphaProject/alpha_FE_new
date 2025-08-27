import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/home_page_controller.dart';
import '../../../helper/image_upload_from_device.dart';

Widget buildImageUploadFAB(BuildContext context) {

  final c =
  Get.isRegistered<HomePageController>()
      ? Get.find<HomePageController>()
      : Get.put<HomePageController>(
    HomePageController(),
    permanent: true,
  );

  return FloatingActionButton(
    shape: const CircleBorder(),
    backgroundColor: const Color(0xFFFF6C57),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("카메라로 촬영"),
                onTap: () async {

                  Navigator.of(context).pop();
                  pickAndUploadImage(ImageSource.camera, c.tourId.value);

                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("갤러리에서 선택"),
                onTap: () async {
                  Navigator.of(context).pop();
                  pickAndUploadImage(ImageSource.gallery, c.tourId.value);
                  // 결과 처리 코드 추가
                },
              ),
            ],
          );
        },
      );
    },
    child: const Icon(Icons.add, color: Colors.white),
  );
}