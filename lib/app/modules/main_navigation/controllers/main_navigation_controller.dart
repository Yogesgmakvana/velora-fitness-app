import 'package:get/get.dart';
import '../../achievements/views/achievements_dialog.dart';

class MainNavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void openAchievementsModal() {
    Get.dialog(
      const AchievementsDialog(),
      barrierDismissible: true,
    );
  }
}
