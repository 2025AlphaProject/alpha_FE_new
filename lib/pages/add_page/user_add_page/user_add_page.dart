import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../final_add_page/final_add_page.dart';

class UserAddPage extends StatelessWidget {
  const UserAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.to(() => FinalAddPage());
        },
        child: Center(
            child: Text('응애 지도는 영욱게이가 넣어줘 응애 응애 응애 응애 임태근 벼@ㅇ신'),
        ),
      ),
    );
  }

}