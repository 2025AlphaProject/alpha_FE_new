import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/login_page_controller.dart';
import '../../../components/bottom_navigation_bar/app_shell.dart';
import '../privacy_agree_page/privacy_agreement_page.dart';

class TesterLogin{
  final controller = Get.find<LoginPageController>();

  //관리자 로그인 이미지 5번 연속 터치 확인 함수
  void testLoginTap(BuildContext context){
    final now = DateTime.now();

    if(controller.lastTapTime == null || now.difference(controller.lastTapTime!) > Duration(seconds: 1)){
      controller.loginTapCount.value = 1;
    } else {
      controller.loginTapCount.value++;
    }
    controller.lastTapTime = now;

    if(controller.loginTapCount.value == 5 ){
      controller.loginTapCount.value = 0;
      showPinDialog(context);
    }
  }

  //관리자 로그인 비밀번호 입력창
  void showPinDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String pin = '';

    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: width * 0.8,
            padding: EdgeInsets.all(width * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '관리자 인증이 필요합니다',
                      style: TextStyle(
                        color: Color(0xFFD3351E),
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      '비밀번호를 입력해 주세요',
                      style: TextStyle(color: Colors.black54, fontSize: width * 0.04),
                    ),
                    SizedBox(height: height * 0.03),
                    GridView.builder(//숫자 키패드
                      shrinkWrap: true,
                      itemCount: 12,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: width > 400 ? 1.4 : 1.2,
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: width * 0.03,
                      ),
                      itemBuilder: (context, index) { //숫자키패드 자리랑 번호
                        String label;
                        if (index == 9) label = '';  //빈칸
                        else if (index == 10) label = '0'; //0
                        else if (index == 11) label = '⌫'; //지우기
                        else label = '${index + 1}'; //1~9

                        return ElevatedButton(
                          onPressed: () {
                            setState(() { //비밀번호 입력
                              if (label == '⌫') {
                                if (pin.isNotEmpty) {
                                  pin = pin.substring(0, pin.length - 1);
                                }
                              } else if (label != '') {
                                pin += label;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(label, style: TextStyle(fontSize: width * 0.046)),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Get.back(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xfff6d1ca),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text('취소', style: TextStyle(color: Color(0xFFD3351E))),
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async { //비밀번호 입력 성공 여부
                              if (pin == controller.testLoginPW) {
                                Get.back();
                                final success = await controller.loginTester(); //관리자 로그인
                                if (success) {

                                  // 테스터 계정 개인정보 동의 여부 확인
                                  if (!controller.isTesterPrivacyAgreed.value) {
                                    final result = await Get.to(() => PrivacyAgreementPage());
                                    if (result) {
                                      controller.isTesterPrivacyAgreed.value = true;
                                      Get.offAll(() => AppShell());
                                    }
                                  }
                                  else{
                                    Get.offAll(() => AppShell());
                                  }

                                } else {
                                  Get.snackbar('오류 발생', '오류가 발생했습니다!');
                                }
                              } else {
                                Get.back();
                                Get.snackbar('실패', '비밀번호가 일치하지 않습니다.');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD3351E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text('확인', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

