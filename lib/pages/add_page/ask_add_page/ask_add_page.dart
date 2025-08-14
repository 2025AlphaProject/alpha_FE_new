import 'package:flutter/material.dart';

import 'buttons/ask_add_page_bottom_button.dart';

class AskAddPage extends StatelessWidget {
  const AskAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/icons/ask_add_page_icon.png',
              width: 200,
            ),
            Text(
                '장소를',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900
              ),
            ),
            Text(
                '추가할까요?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: AskAddPageBottomButton(),
        ),
      )
    );
  }
}