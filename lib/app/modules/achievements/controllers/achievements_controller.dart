import 'package:get/get.dart';

class AchievementsController extends GetxController {
  final targetSteps = 10000.obs;
  final progress = 1.0.obs;

  void dismissDialog() {
    Get.back();
  }
}
