import 'delete_tour_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:conever/controllers/plan_page_controller.dart';
import 'package:conever/components/bottom_navigation_bar/app_shell.dart';
import 'package:conever/controllers/bottom_navigation_controller.dart';

import 'change_date.dart';

class EditFunction{
  final controller = Get.find<PlanPageController>();
  final TextEditingController _titleEditController = TextEditingController();

  //여행 장소 삭제_1(삭제 가능 상태로 바꾸기)
  void deletePlaces(){
    controller.isEditMode.value = !controller.isEditMode.value;
    Get.back();
  }

  //여행 장소 삭제_2(장소 삭제)
  void deletePlace(BuildContext context, String placename,int place_id){
    final width = MediaQuery.of(context).size.width;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("여행 날짜 수정", style: TextStyle(fontSize: width * 0.05, color: Color(0xccD3351E),),),
        content: Text("'${placename}'를 여행에서 삭제하시겠습니까?", style: TextStyle(fontSize: width * 0.04),),
        actions: [
          TextButton( //장소 삭제 취소 버튼
            onPressed: () {Get.back();},
            style: TextButton.styleFrom(backgroundColor: Color(0xfff6d1ca),),
            child: Text("취소", style: TextStyle(color: Color(0xffD3351E)),),
          ),
          TextButton( //장소 삭제 버튼
            onPressed: () async {
              final response = await controller.deletePlace(controller.course['id'], place_id);
              if(response){
                controller.tourCourse(controller.course['id']);
                Get.back();
              }
            },
            style: TextButton.styleFrom(backgroundColor: Color(0xffD3351E),),
            child: Text("삭제", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  //여행 제목 수정
  void renameTour(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    Get.back();
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          title: Text('여행 제목 수정',style: TextStyle(fontSize: width*0.05,color: Color(0xccD3351E)),),
          content: TextField(
            maxLength: 10,
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
                    controller.tourCourse(controller.course['id']);
                    Get.back();
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
  void deleteTour(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    Get.back();
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white,
          title: Text("여행 삭제",style: TextStyle(fontSize: width*0.05,color: Color(0xccD3351E), fontWeight: FontWeight.bold),),
          content: RichText(
            text: TextSpan(
              text: '${controller.course['tour_name']}',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '을 삭제하시겠습니까?\n',
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: '여행을 삭제하실 경우, 인생네컷도 앨범에서 삭제됩니다!',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          actions: [
            TextButton( //취소버튼
                onPressed: (){Get.back();},
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xfff6d1ca)
                ),
                child: Text("취소",style: TextStyle(color:Color(0xffD3351E)))
            ),
            TextButton( //삭제 버튼
                onPressed: () async {
                  final response = await controller.deleteTour(controller.course['id']);
                  if(response){
                    Get.to(()=> DeleteTourPage());
                  }
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