import 'package:get/get.dart';
import '../controllers/steps_detail_controller.dart';

class StepsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StepsDetailController>(() => StepsDetailController());
  }
}
