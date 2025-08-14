import 'package:conever/pages/my_page/create_inseng_4_cut/components/save_four_cut_as_image.dart';
import 'package:flutter/material.dart';

import 'components/four_cut_frame.dart';

class CreateInseng4CutFinish extends StatelessWidget {
  final List<String> imagePaths = const [
    'assets/dummy/dummy_image1.png',
    'assets/dummy/dummy_image2.png',
    'assets/dummy/dummy_image3.png',
    'assets/dummy/dummy_image4.png',
  ];

  const CreateInseng4CutFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FourCutFrame(imagePaths: imagePaths),
      ),
    );
  }
}