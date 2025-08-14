import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_inseng_4_cut_finish.dart';

class CreateInseng4CutLoading extends StatefulWidget {
  const CreateInseng4CutLoading({super.key});

  @override
  State<CreateInseng4CutLoading> createState() => _CreateInseng4CutLoadingState();
}

class _CreateInseng4CutLoadingState extends State<CreateInseng4CutLoading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      Get.to(() => CreateInseng4CutFinish());
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              color: Color(0xFFD3351E),
              radius: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "인생 네컷 생성 중...",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: width * 0.076,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}