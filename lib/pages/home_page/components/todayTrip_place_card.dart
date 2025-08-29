// 장소 카드 단일 아이템 뷰
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String imageUrl;

  const PlaceCard({super.key, required this.title, this.onTap, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 플레이스홀더
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.02),
              child: imageUrl != ''
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  :Container(
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Icon(
                  Icons.image,
                  size: size.width * 0.08,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // 이미지와 텍스트 사이 여백
          SizedBox(height: size.height * 0.008),

          // 장소명 텍스트
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
