import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/day_model.dart';
import '../../../data/providers/app_database.dart';
import '../../../data/providers/fitness_data_provider.dart';
import '../../../data/services/step_tracking_service.dart';
import '../../../data/services/user_preferences_service.dart';
import '../../../routes/app_routes.dart';
import '../../achievements/views/achievements_dialog.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';

class HomeController extends GetxController {
  final AppDatabase _db = AppDatabase.instance;
  late final StepTrackingService trackingService;
  late final UserPreferencesService prefService;

  final isLoading = true.obs;

  final weekDays = <DayModel>[].obs;
  final selectedDayIndex = 0.obs;
  final currentNavIndex = 0.obs;

  // Metric values
  final readinessScore = 92.obs;
  final readinessGoal = 85.obs;

  final sleepHours = 7.4.obs;
  final sleepGoalHours = 9.0.obs;

  final gymCompleted = 2.obs;
  final gymTotal = 4.obs;

  final stepsCurrent = 0.obs;
  final stepsTarget = 10000.obs;

  final proteinCurrent = 160.obs;
  final proteinTarget = 300.obs;

  final caloriesCurrent = 245.obs;
  final currentWeight = 62.5.obs;

  @override
  void onInit() {
    super.onInit();
    _initServices();
    loadWeekDays();
    _loadStoredMetrics();
    _simulateLoading();
  }

  void _initServices() {
    prefService = Get.find<UserPreferencesService>();
    stepsTarget.value = prefService.dailyStepGoal.value;
    sleepGoalHours.value = prefService.dailySleepGoal.value;
    proteinTarget.value = prefService.dailyProteinGoal.value;
    currentWeight.value = prefService.targetWeight.value;

    // Listen to pref changes
    prefService.dailyStepGoal.listen((val) => stepsTarget.value = val);
    prefService.dailySleepGoal.listen((val) => sleepGoalHours.value = val);
    prefService.dailyProteinGoal.listen((val) => proteinTarget.value = val);
    prefService.targetWeight.listen((val) => currentWeight.value = val);

    if (Get.isRegistered<StepTrackingService>()) {
      trackingService = Get.find<StepTrackingService>();
    } else {
      trackingService = Get.put<StepTrackingService>(StepTrackingServiceImpl());
    }

    // Bind current live step count & recalculate calories
    stepsCurrent.bindStream(trackingService.currentDailySteps.stream);
    stepsCurrent.value = trackingService.currentDailySteps.value;

    stepsCurrent.listen((steps) {
      _recalculateCalories();
      _recalculateReadiness();
    });

    startStepTracking();
  }

  Future<void> _loadStoredMetrics() async {
    final dateKey = trackingService.getTodayDateKey();
    final activity = await _db.getDailyActivity(dateKey);

    if (activity != null) {
      sleepHours.value = (activity['sleep_hours'] as num?)?.toDouble() ?? 7.4;
      gymCompleted.value = (activity['gym_completed'] as int?) ?? 2;
      proteinCurrent.value = (activity['protein'] as int?) ?? 160;
      caloriesCurrent.value = (activity['calories'] as int?) ?? 245;
      readinessScore.value = (activity['readiness'] as int?) ?? 92;
      currentWeight.value = (activity['weight_kg'] as num?)?.toDouble() ?? 62.5;
    }
  }

  void _recalculateCalories() {
    final stepBurn = (stepsCurrent.value * 0.035).round();
    final gymBurn = gymCompleted.value * 120;
    caloriesCurrent.value = 200 + stepBurn + gymBurn;
    _saveMetricsToDb();
  }

  void _recalculateReadiness() {
    final sleepRatio = (sleepHours.value / sleepGoalHours.value).clamp(0.0, 1.2);
    final stepRatio = (stepsCurrent.value / stepsTarget.value).clamp(0.0, 1.2);
    final calculated = (60 + (sleepRatio * 20) + (stepRatio * 20)).round().clamp(65, 99);
    readinessScore.value = calculated;
  }

  Future<void> _saveMetricsToDb() async {
    final dateKey = trackingService.getTodayDateKey();
    await _db.upsertDailyMetrics(
      dateKey: dateKey,
      steps: stepsCurrent.value,
      stepGoal: stepsTarget.value,
      sleepHours: sleepHours.value,
      sleepGoal: sleepGoalHours.value,
      gymCompleted: gymCompleted.value,
      gymTotal: gymTotal.value,
      protein: proteinCurrent.value,
      proteinGoal: proteinTarget.value,
      calories: caloriesCurrent.value,
      readiness: readinessScore.value,
      weightKg: currentWeight.value,
    );
  }

  // Interactive Actions
  Future<void> addProtein(int grams) async {
    proteinCurrent.value = (proteinCurrent.value + grams).clamp(0, 1000);
    await _saveMetricsToDb();
    Get.snackbar(
      'Protein Logged',
      '+$grams g added. Total today: ${proteinCurrent.value}g',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.cardBackground,
      colorText: AppColors.proteinPurple,
    );
  }

  Future<void> updateSleepHours(double hours) async {
    sleepHours.value = hours;
    _recalculateReadiness();
    await _saveMetricsToDb();
    Get.snackbar(
      'Sleep Updated',
      'Logged ${hours.toStringAsFixed(1)} hrs sleep',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.cardBackground,
      colorText: AppColors.sleepYellow,
    );
  }

  Future<void> incrementGymSession() async {
    if (gymCompleted.value < gymTotal.value) {
      gymCompleted.value += 1;
      _recalculateCalories();
      await _saveMetricsToDb();
      Get.snackbar(
        'Gym Session Logged',
        'Workout ${gymCompleted.value}/${gymTotal.value} completed! 💪',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.cardBackground,
        colorText: AppColors.gymTeal,
      );
    }
  }

  Future<void> updateWeight(double weightKg) async {
    currentWeight.value = weightKg;
    await _db.insertWeightEntry(weightKg);
    await _saveMetricsToDb();
    Get.snackbar(
      'Weight Updated',
      'Weight logged: ${weightKg.toStringAsFixed(1)} kg',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.cardBackground,
      colorText: AppColors.weightOrange,
    );
  }

  Future<void> _simulateLoading() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isLoading.value = false;
  }

  Future<void> startStepTracking() async {
    await trackingService.startTracking();
  }

  Future<void> stopStepTracking() async {
    await trackingService.stopTracking();
  }

  void loadWeekDays() {
    final realDays = FitnessDataProvider.getWeekDays();
    weekDays.assignAll(realDays);

    // Set active selected index to real today
    final now = DateTime.now();
    selectedDayIndex.value = now.weekday % 7;
  }

  void selectDay(int index) {
    selectedDayIndex.value = index;
    for (int i = 0; i < weekDays.length; i++) {
      weekDays[i] = weekDays[i].copyWith(isSelected: i == index);
    }
  }

  void openSettingsTab() {
    if (Get.isRegistered<MainNavigationController>()) {
      Get.find<MainNavigationController>().changeTab(4);
    }
  }

  void onNavTabSelected(int index) {
    currentNavIndex.value = index;
    if (index == 1) {
      openAchievementsModal();
    }
  }

  void openAchievementsModal() {
    Get.dialog(
      const AchievementsDialog(),
      barrierDismissible: true,
    );
  }

  void openStepsDetail() {
    Get.toNamed(AppRoutes.STEPS_DETAIL);
  }
}
