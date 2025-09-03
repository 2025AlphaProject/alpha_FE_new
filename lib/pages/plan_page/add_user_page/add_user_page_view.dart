import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conever/controllers/plan_page_controller.dart';
import 'components/user_pofile.dart';

// 사용자 추가 페이지 위젯
class addUser extends StatefulWidget {
  const addUser({super.key});

  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {
  final controller = Get.find<PlanPageController>();

  // 검색창 관리용
  final TextEditingController _searchController = TextEditingController();
  final RxString _searchQuery = ''.obs;
  bool isSearchVisible = false;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(
            onPressed: (){
              controller.tourCourse(controller.course['id']); // 상태 새로고침
              Get.back();
              },
            icon: Icon(Icons.arrow_back_ios_outlined,color: Color(0xCCD3351E),)
        ),
        title: Text("동행자 추가",style: TextStyle(color:Color(0xCCD3351E) ),),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchVisible = !isSearchVisible;
                });
              },
              icon: Icon(Icons.search, color: Color(0xCCD3351E),)
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(width *0.05, 0, width *0.05, height * 0.01),
        child: Column(
          children: [
            if(isSearchVisible)
            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
              child: TextField( //검색창
                controller: _searchController,
                onChanged: (value) {
                  _searchQuery.value = value;
                },
                decoration: InputDecoration(
                  hintText: '검색...',
                  hintStyle: TextStyle(fontSize: width *0.03, color: Color(0xCCD3351E)),
                  prefixIcon: Icon(Icons.search, size: width*0.05, color: Color(0xCCD3351E),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xffD3351E), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xffD3351E), width: 1.5),
                  ),
                ),
              ),
            ),
            Expanded( //유저 리스트
              child: Obx(
                () => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.user.where((u) {
                        final username = u['username']?.toString() ?? ''; //검색조건에 맞는  유저들 필터링
                        final query = _searchQuery.value.toLowerCase();
                        return username.toLowerCase().contains(query);
                      }).map((u) {
                        return UserPofile( //조건에 맞는 유저 표시
                          imageUrl: u['profile_image_url'],
                          username: u['username'],
                          sub: u['sub'],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
