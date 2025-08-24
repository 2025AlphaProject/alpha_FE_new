import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../final_add_page/final_add_page.dart';
import '../../final_add_page/final_loading_page.dart';
import '../../user_add_page/user_add_page.dart';

class AskAddPageBottomButton extends StatelessWidget {
  const AskAddPageBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(onPressed: () {
          Get.to(() => FinalLoadingPage());
        },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[300],
                fixedSize: Size(width * 0.4, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            child: Text(
              '괜찮아요',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            )),
        ElevatedButton(onPressed: () {
          Get.to(() => UserAddPage());
        },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFD3351E),
                fixedSize: Size(width * 0.45, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            child: Text(
              '장소 추가하기',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            )),
      ],
    );
  }

}