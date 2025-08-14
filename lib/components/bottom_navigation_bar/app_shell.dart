import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/bottom_navigation_controller.dart';
import 'bottom_navigation_bar.dart';
import 'destinations.dart';

class AppShell extends GetView<NavigationController> {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: BottomNav(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
          items: bottomNavItems,
        ),
      );
    });
  }
}