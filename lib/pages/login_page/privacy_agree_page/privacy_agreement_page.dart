import 'package:conever/services/access_token/post_privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyAgreementPage extends StatefulWidget {
  const PrivacyAgreementPage({super.key});

  @override
  State<PrivacyAgreementPage> createState() => _PrivacyAgreementPageState();
}

class _PrivacyAgreementPageState extends State<PrivacyAgreementPage> {
  bool agreePhoto = false;
  bool agreeNotice = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.04),
              Container(
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '개인정보 수집·이용에 대한 동의',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      '커네버 필수 서비스 제공을 위해 개인정보 수집과 이용에 관한 동의를 받고자 합니다. 아래 보기에서 동의 여부를 선택해 주세요.',
                      style: TextStyle(fontSize: size.width * 0.035),
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text('• 제 3자 제공: 없음'),
                    Text('• 처리위탁(수탁자): AWS(서울 리전)'),
                    Text('• 국외 이전: 해당 없음'),
                    Text('• 수집 목적: 인생네컷 프레임 합성 및 결과 제공, 여행 사진 저장'),
                    Text('• 수집 항목: 사용자가 업로드한 사진(이미지 파일), 메타데이터 제거 후 저장'),
                    Text('• 보유 및 이용 기간: 사용자가 삭제시 즉시 파기'),
                    Text('• 문의처: ytk030305@naver.com'),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      '* 귀하께서는 동의하지 않을 권리가 있습니다. 동의하지 않을 경우 커네버의 필수 서비스 이용에 제한이 있을 수 있습니다.',
                      style: TextStyle(fontSize: size.width * 0.033),
                    ),
                    SizedBox(height: size.height * 0.02),
                    CheckboxListTile(
                      title: Text('(필수) 사진 처리 및 보관 동의 (미동의 시 커네버 필수 서비스 이용 제한)'),
                      value: agreePhoto,
                      onChanged: (val) => setState(() => agreePhoto = val!),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: Text('(필수) 고지사항 확인 (단순 고지 확인)'),
                      value: agreeNotice,
                      onChanged: (val) => setState(() => agreeNotice = val!),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text('동의서 버전: 1.0', style: TextStyle(fontSize: size.width * 0.03)),
                  ],
                ),
              ),
              Spacer(),
              Opacity(
                opacity: (agreePhoto && agreeNotice) ? 1.0 : 0.4,
                child: GestureDetector(
                  onTap: () async {
                    if (agreePhoto && agreeNotice) {
                      try {
                        await postPrivacyPolicy(privacyPolicyAgree: true, privacyPolicyVersion: "1.0");
                        Get.back(result: true);
                      }
                      catch (e) {
                        Get.snackbar('오류', '개인정보 수집 동의 실패');
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    margin: EdgeInsets.only(bottom: size.height * 0.02),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFD93636),
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                    ),
                    child: Text(
                      '확인 및 동의 완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}