import 'package:get/get.dart';

import '../../controllers/bottom_navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController(), permanent: true);
  }
}