import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../helper/image_upload_from_device.dart';


class TodayTripPlaceDetailPage extends StatelessWidget {
  const TodayTripPlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final c =
    Get.isRegistered<HomePageController>()
        ? Get.find<HomePageController>()
        : Get.put<HomePageController>(
      HomePageController(),
      permanent: true,
    );

    // 라우트 인자 수신
    final args = (Get.arguments ?? {}) as Map;
    final title = (args['title'] ?? '장소 제목') as String;
    final category = (args['category'] ?? '음식점') as String;
    final region = (args['region'] ?? '충남 아산(대분류만)') as String;
    final jibun = (args['jibun'] ?? '지번 주소가 없습니다') as String;
    final road = (args['road'] ?? '도로명 주소가 없습니다') as String;
    final imageUrl = args['imageUrl'] as String?;
    final id = args['id'] as int;



    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 섹션 제목
              Text(
                '장소 상세정보',
                style: TextStyle(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // 섹션 여백
              SizedBox(height: size.height * 0.012),

              // 상세 카드 컨테이너
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width * 0.025),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 대표 이미지
                    ClipRRect(
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child:
                            imageUrl == null
                                ? Container(
                                  color: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.image,
                                    size: size.width * 0.12,
                                    color: Colors.white,
                                  ),
                                )
                                : Image.network(imageUrl, fit: BoxFit.cover),
                      ),
                    ),

                    // 이미지와 텍스트 사이 여백
                    SizedBox(height: size.height * 0.015),

                    // 카테고리 뱃지
                    CategoryBadge(context, category),

                    // 뱃지와 제목 사이 여백
                    SizedBox(height: size.height * 0.008),

                    // 장소 제목
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    // 제목과 주소 사이 여백
                    SizedBox(height: size.height * 0.01),

                    // 지역 정보
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: size.width * 0.04,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Flexible(
                          child: Text(
                            region,
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 주소 블록 여백
                    SizedBox(height: size.height * 0.012),

                    // 지번/도로명 주소
                    AddressLine(context, '지번', jibun),
                    SizedBox(height: size.height * 0.006),
                    AddressLine(context, '도로명', road),
                  ],
                ),
              ),

              // 상세 카드와 추천 포즈 사이 여백
              SizedBox(height: size.height * 0.03),

              // 추천 포즈 섹션 제목
              Center(
                child: Text(
                  '이런 포즈 어때요?',
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              // 제목과 컨텐츠 사이 여백
              SizedBox(height: size.height * 0.015),

              // 추천 포즈 컨텐츠 박스
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < c.poses.length; i++) ...[
                      PoseItem(
                        context,
                        index: i,
                        desc: c.poses[i],
                        imgPath: c.poseImages[i],
                      ),
                      if (i != c.poses.length - 1)
                        SizedBox(height: size.height * 0.04),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
          Positioned(
            bottom: size.height * 0.03,
            right: size.width * 0.05,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFFFF6C57),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('사진 업로드'),
                          onTap: () {
                            Navigator.pop(context);
                            pickAndUploadImage(ImageSource.gallery, c.tourId.value);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('촬영 후 업로드'),
                          onTap: () {
                            Navigator.pop(context);
                            pickAndUploadImage(ImageSource.camera, c.tourId.value);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
    ]
      ),
    );
  }
}

/// 카테고리 배지 뷰

Widget CategoryBadge(BuildContext context, String label) {
  final size = MediaQuery.of(context).size;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.025,
      vertical: size.height * 0.005,
    ),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(size.width * 0.02),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.03,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// 주소 한 줄 표시 뷰
Widget AddressLine(BuildContext context, String label, String value) {
  final size = MediaQuery.of(context).size;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: size.width * 0.12,
        child: Text(
          label,
          style: TextStyle(
            fontSize: size.width * 0.034,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(width: size.width * 0.01),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: size.width * 0.034,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ],
  );
}

/// 포즈 아이템 뷰
Widget PoseItem(
  BuildContext context, {
  required int index,
  required String desc,
  required String imgPath,
}) {
  final size = MediaQuery.of(context).size;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // 포즈 이미지 영역
      ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.02),
        child:
            imgPath.isEmpty
                ? Container(
                  height: size.height * 0.24,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image,
                    size: size.width * 0.18,
                    color: Colors.black26,
                  ),
                )
                : Image.network(
                  imgPath,
                  height: size.height * 0.24,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
      ),

      // 이미지와 텍스트 사이 여백
      SizedBox(height: size.height * 0.02),

      // 포즈 제목
      Text(
        '포즈 ${index + 1}.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.w800,
        ),
      ),

      // 제목과 설명 사이 여백
      SizedBox(height: size.height * 0.008),

      // 포즈 설명
      Text(
        desc,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size.width * 0.035,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
