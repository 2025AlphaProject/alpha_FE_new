import 'package:flutter/material.dart';
import 'plan_page_1/plan_page_1_view.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: Text('계획 페이지입니다')),
      body: PlanPage1()
    );
  }

}