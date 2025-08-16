import 'package:flutter/material.dart';

class TodayTripPhotosPage extends StatelessWidget {
  const TodayTripPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // 더미 사진 목록 (비어 있으면 빈 상태 표시)
    final photos = <String>[];

    // 빈 상태 표시

    if (photos.isEmpty) {
      return Center(
        child: Text(
          '업로드한 사진이 없습니다',
          style: TextStyle(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    // 사진 그리드 표시

    return Padding(
      padding: EdgeInsets.all(size.width * 0.02),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _gridCount(size.width),
          crossAxisSpacing: size.width * 0.02,
          mainAxisSpacing: size.width * 0.02,
          childAspectRatio: 1,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(size.width * 0.02),
            child: Container(
              color: Colors.grey.shade300,
              child: Icon(
                Icons.photo,
                size: size.width * 0.08,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  // 화면 너비에 따른 그리드 열 개수 결정

  int _gridCount(double width) {
    if (width >= 1200) return 6;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }
}
