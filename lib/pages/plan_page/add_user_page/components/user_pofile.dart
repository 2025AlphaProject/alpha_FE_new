import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/controllers/bottom_navigation_controller.dart';
import 'package:conever/controllers/plan_page_controller.dart';
import '../../../../components/bottom_navigation_bar/app_shell.dart';

class UserPofile extends StatelessWidget {
  final String imageUrl;
  final String username;
  final int sub;

  const UserPofile({super.key,
    required this.imageUrl,
    required this.username,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.find<PlanPageController>();


    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.01, height * 0.01, 0, height * 0.007),
      child: Container(
        child: Row(
          children: [
            CircleAvatar( //유저 프로필
              radius: width * 0.058,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: width * 0.05),
            Container( // 유저 이름
              width: width * 0.57,
              child: Text(
                username,
                style: TextStyle(fontSize: width * 0.04, color: Colors.black),
              ),
            ),
            IconButton( //친구 추가 버튼
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text("동행자 추가",style: TextStyle(fontSize: width*0.05,color: Color(0xccD3351E))),
                    content: Text("이 여행에 '${username}'을 추가하시겠습니까?",style: TextStyle(fontSize: width*0.04)),
                    actions: [
                      TextButton( //취소버튼
                          onPressed: (){Get.back();},
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xfff6d1ca)
                          ),
                          child: Text("취소",style: TextStyle(color:Color(0xffD3351E)))
                      ),
                      TextButton( //추가 버튼
                          onPressed: (){
                            final response = controller.addUser(sub, controller.course['id']); // 유저 추가
                            if(response == true){
                              final naviController = Get.find<NavigationController>();
                              naviController.tabIndex.value = 0;  // 계획 페이지 이동
                              Get.offAll(() => AppShell());
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xffD3351E)
                          ),
                          child: Text("추가",style: TextStyle(color: Colors.white),)
                      )
                    ],
                  )
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
