import 'package:conever/controllers/login_page_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../travel_path/travel_path_painter.dart';

class LoginPage1View extends StatelessWidget {
  final List<double> animationProgress;
  final int currentTextIndex;


  const LoginPage1View({
    super.key,
    required this.animationProgress,
    required this.currentTextIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          double width = MediaQuery.of(context).size.width;
          if (kIsWeb) {
            width = 410;
          }
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.43,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.0533, height * 0.246, width * 0.0533, 0),
                      child: Center(
                        child: Column(
                          children: [
                            AnimatedOpacity(
                              opacity: currentTextIndex >= 0 ? 1.0 : 0.0,duration: const Duration(milliseconds: 500),
                              child: Text(
                                "어디로 떠날지가 고민이신가요?",
                                style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: currentTextIndex >= 1 ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "AI가 추천하는 여행지를 확인하고,",
                                style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: currentTextIndex >= 2 ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "가장 특별한 여행을 떠나보세요!",
                                style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.5,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              heightFactor: 1.0,
                              child: Image.asset(
                                'assets/images/seoul_image.jpg',
                              ),
                            ),
                          ),
                        ),
                        CustomPaint(
                          painter: TravelPathPainter(animationProgress),
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}