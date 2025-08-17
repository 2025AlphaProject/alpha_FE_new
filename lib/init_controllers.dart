import 'package:conever/controllers/home_page_controller.dart';
import 'package:get/get.dart';

import 'controllers/add_page_controller.dart';
import 'controllers/login_page_controller.dart';
import 'controllers/my_page_controller.dart';

void initControllers() {
  Get.put(LoginPageController());
  Get.put(AddPageController());
  Get.put(MyPageController());
  Get.put(HomePageController());
}
