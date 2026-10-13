import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/main_navigation_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
