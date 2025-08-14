import 'package:flutter/material.dart';

import 'view/login_page2_view.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final List<bool> visibleList = [false, false, false];

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  Future<void> startAnimation() async {
    for (int i = 0; i < visibleList.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        visibleList[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage2View(visibleList: visibleList);
  }
}