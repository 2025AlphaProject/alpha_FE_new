import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/bottom_navigation_bar/app_shell.dart';
import 'save_four_cut_as_image.dart';

class FourCutFrame extends StatefulWidget {
  final List<String> imagePaths; // 길이 4

  const FourCutFrame({super.key, required this.imagePaths});

  @override
  State<FourCutFrame> createState() => _FourCutFrameState();
}

class _FourCutFrameState extends State<FourCutFrame> {
  final GlobalKey _captureKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: height * 0.1184,),
        Column(
          children: [
            RepaintBoundary(
              key: _captureKey,
              child: SizedBox(
                width: width * 0.9,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                        children: List.generate(4, (i) {
                          return ClipRRect(
                            child: Image.asset(
                              widget.imagePaths[i],
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                  '나만의 인생 네컷이 완성되었어요!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.0641
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                  try {
                    final ok = await captureAndSave(
                        _captureKey,
                        pixelRatio: 3.0,
                        name: 'fourcut_${DateTime.now().millisecondsSinceEpoch}'
                    );

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          ok ? '갤러리에 저장됐어요' : '저장에 실패했어요. 다시 시도해주세요',
                          style: TextStyle(
                              color: Colors.black
                          )), backgroundColor: Colors.white,
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          '오류 발생: $e',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                        Icons.save_alt,
                      size: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                          '사진 저장하기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => AppShell());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFD3351E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                  "완료",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}