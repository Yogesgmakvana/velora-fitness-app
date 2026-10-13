import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService extends GetxService {
  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keyUserName = 'user_name';
  static const String _keyDailyStepGoal = 'daily_step_goal';
  static const String _keyDailySleepGoal = 'daily_sleep_goal';
  static const String _keyDailyProteinGoal = 'daily_protein_goal';
  static const String _keyTargetWeight = 'target_weight';

  SharedPreferences? _prefs;

  final RxBool isFirstTime = true.obs;
  final RxString userName = 'Sofia'.obs;
  final RxInt dailyStepGoal = 10000.obs;
  final RxDouble dailySleepGoal = 9.0.obs;
  final RxInt dailyProteinGoal = 300.obs;
  final RxDouble targetWeight = 65.0.obs;

  Future<UserPreferencesService> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _loadPreferences();
    } catch (e) {
      // Fallback default values
      isFirstTime.value = true;
      userName.value = 'Sofia';
    }
    return this;
  }

  void _loadPreferences() {
    if (_prefs == null) return;
    isFirstTime.value = _prefs!.getBool(_keyIsFirstTime) ?? true;
    userName.value = _prefs!.getString(_keyUserName) ?? 'Sofia';
    dailyStepGoal.value = _prefs!.getInt(_keyDailyStepGoal) ?? 10000;
    dailySleepGoal.value = _prefs!.getDouble(_keyDailySleepGoal) ?? 9.0;
    dailyProteinGoal.value = _prefs!.getInt(_keyDailyProteinGoal) ?? 300;
    targetWeight.value = _prefs!.getDouble(_keyTargetWeight) ?? 65.0;
  }

  Future<void> saveUserData({
    required String name,
    required int stepGoal,
    required double weight,
  }) async {
    userName.value = name.isNotEmpty ? name : 'Sofia';
    dailyStepGoal.value = stepGoal;
    targetWeight.value = weight;
    isFirstTime.value = false;

    if (_prefs != null) {
      await _prefs!.setString(_keyUserName, userName.value);
      await _prefs!.setInt(_keyDailyStepGoal, dailyStepGoal.value);
      await _prefs!.setDouble(_keyTargetWeight, targetWeight.value);
      await _prefs!.setBool(_keyIsFirstTime, false);
    }
  }

  Future<void> updateStepGoal(int newGoal) async {
    dailyStepGoal.value = newGoal;
    if (_prefs != null) {
      await _prefs!.setInt(_keyDailyStepGoal, newGoal);
    }
  }

  Future<void> updateSleepGoal(double newGoal) async {
    dailySleepGoal.value = newGoal;
    if (_prefs != null) {
      await _prefs!.setDouble(_keyDailySleepGoal, newGoal);
    }
  }

  Future<void> updateProteinGoal(int newGoal) async {
    dailyProteinGoal.value = newGoal;
    if (_prefs != null) {
      await _prefs!.setInt(_keyDailyProteinGoal, newGoal);
    }
  }

  Future<void> resetOnboarding() async {
    if (_prefs != null) {
      await _prefs!.clear();
    }
    _loadPreferences();
  }
}
