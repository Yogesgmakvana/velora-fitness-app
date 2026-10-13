import 'package:get/get.dart';
import '../../../data/models/day_model.dart';
import '../../../data/models/step_stat_model.dart';
import '../../../data/providers/app_database.dart';
import '../../../data/providers/fitness_data_provider.dart';

class StepsDetailController extends GetxController {
  final _db = AppDatabase.instance;

  final daysList = <DayModel>[].obs;
  final weeklyStats = <StepStatModel>[].obs;
  
  final selectedBarIndex = 6.obs; // Default selected bar (Today)
  final selectedFilter = 'Past weeks'.obs;

  @override
  void onInit() {
    super.onInit();
    loadStepsData();
  }

  Future<void> loadStepsData() async {
    daysList.assignAll(FitnessDataProvider.getStepsWeekDays());

    final dbStats = await _db.getWeeklyStepStats();
    if (dbStats.isNotEmpty) {
      weeklyStats.assignAll(dbStats);
      selectedBarIndex.value = dbStats.length - 1;
    } else {
      weeklyStats.assignAll(FitnessDataProvider.getWeeklyStepStats());
    }
  }

  void selectBar(int index) {
    selectedBarIndex.value = index;
  }

  void goBack() {
    Get.back();
  }

  void onSharePressed() {
    Get.snackbar(
      'Share Progress',
      'Step progress ready to share!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
