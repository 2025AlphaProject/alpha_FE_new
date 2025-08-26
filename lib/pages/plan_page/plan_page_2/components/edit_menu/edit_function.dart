import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/controllers/plan_page_controller.dart';
import 'package:conever/components/bottom_navigation_bar/app_shell.dart';
import 'package:conever/controllers/bottom_navigation_controller.dart';

import 'change_date.dart';

class EditFunction{
  final controller = Get.find<PlanPageController>();
  final TextEditingController _titleEditController = TextEditingController();

  //여행 장소 삭제
  void deletePlace(){
    controller.isEditMode.value = !controller.isEditMode.value;
    Get.back();
  }

  //여행 제목 수정
  void renameTour(){
    Get.back();
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          title: Text('여행제목 수정'),
          content: TextField(
            controller: _titleEditController,
            decoration: InputDecoration(
              hintText: '${controller.course['tour_name']}',
            ),
          ),
          actions: [
            TextButton( //취소 버튼
                onPressed: (){Get.back();},
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xfff6d1ca)
                ),
                child: Text("취소",style: TextStyle(color:Color(0xffD3351E)))
            ),
            TextButton( //수정 버튼
                onPressed: () async {
                  final response = await controller.editName(controller.course['id'], _titleEditController.text);
                  if(response){
                    final naviController = Get.find<NavigationController>();
                    naviController.tabIndex.value = 0;  // 계획 페이지 이동
                    Get.offAll(() => AppShell());

                  }

                },
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xffD3351E)
                ),
                child: Text("수정",style: TextStyle(color: Colors.white),)
            )
          ],
        )
    );
  }

  //여행 날짜 수정
  void changeDate(BuildContext context){
    Get.back();
    showDateEditBottomSheet(context);
  }

  //여행 삭제
  void deleteTour(){
    Get.back();
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          title: Text("여행삭제"),
          content: Text("'${controller.course['tour_name']}'을 삭제하시겠습니까?"),
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
                },
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xffD3351E)
                ),
                child: Text("삭제",style: TextStyle(color: Colors.white),)
            )
          ],
        )
    );
  }
}