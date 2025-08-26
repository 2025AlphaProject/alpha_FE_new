import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../pages/add_page/add_page_1/add_page_1_view.dart';
import '../pages/home_page/home_page.dart';
import '../pages/my_page/my_page.dart';
import '../pages/plan_page/plan_page_1/plan_page_1_view.dart';

class NavigationController extends GetxController {
  final RxInt tabIndex = 0.obs;

  final pages = <Widget>[
    const HomePage(),
    const PlanPage1(),
    const AddPage1(),
    const MyPage(),
  ];

  void changeTab(int index) {
    tabIndex.value = index;
  }
}
