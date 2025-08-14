import 'package:conever/pages/my_page/photo_album/image_detail.dart';
import 'package:flutter/material.dart';

class Inseng4Cut extends StatelessWidget {
  const Inseng4Cut({super.key});

  final List<String> imagePaths = const [
    'assets/dummy/dummy_image1.png',
    'assets/dummy/dummy_image2.png',
    'assets/dummy/dummy_image3.png',
    'assets/dummy/dummy_image4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 43.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '동언님의 아카이브',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              const SizedBox(width: 6),
              Text(
                '${imagePaths.length}장',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          SizedBox(height: 38),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                final path = imagePaths[index];
                return GestureDetector(
                  onTap: () {
                    showImageDetail(context, imagePaths, index);
                  },
                  child: Hero(
                    tag: path,
                    child: ClipRRect(
                      child: Image.asset(
                        path,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const ColoredBox(
                          color: Colors.black12,
                          child: Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}