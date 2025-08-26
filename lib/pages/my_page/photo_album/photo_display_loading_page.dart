import 'package:conever/pages/my_page/photo_album/photo_album_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/my_page_controller.dart';


class PhotoDisplayLoadingPage extends StatefulWidget {
  const PhotoDisplayLoadingPage({super.key});

  @override
  State<PhotoDisplayLoadingPage> createState() => _PhotoDisplayLoadingPageState();
}

class _PhotoDisplayLoadingPageState extends State<PhotoDisplayLoadingPage> {
  final controller = Get.find<MyPageController>();
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    controller.getUserDetailTours();
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => PhotoAlbumDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              color: Color(0xFFD3351E),
              radius: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "정보를\n불러오고 있습니다...",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: width * 0.076,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}