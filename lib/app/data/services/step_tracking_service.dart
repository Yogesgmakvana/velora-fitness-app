import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../providers/app_database.dart';

abstract interface class StepTrackingService {
  RxInt get currentDailySteps;
  RxBool get isTracking;
  RxString get statusMessage;

  Future<bool> requestPermission();
  Future<void> startTracking();
  Future<void> stopTracking();
  String getTodayDateKey();
}

class StepTrackingServiceImpl extends GetxService implements StepTrackingService {
  final AppDatabase _db = AppDatabase.instance;

  @override
  final RxInt currentDailySteps = 0.obs;

  @override
  final RxBool isTracking = false.obs;

  @override
  final RxString statusMessage = 'Initializing step tracker...'.obs;

  StreamSubscription<StepCount>? _stepCountSubscription;
  int? _todayBaseline;
  int? _lastSensorReading;

  @override
  String getTodayDateKey() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await _loadStoredTodaySteps();
    } catch (e) {
      statusMessage.value = 'Offline step tracker ready';
    }
  }

  Future<void> _loadStoredTodaySteps() async {
    final dateKey = getTodayDateKey();
    final storedActivity = await _db.getDailyActivity(dateKey);

    if (storedActivity != null) {
      currentDailySteps.value = (storedActivity['steps'] as int?) ?? 0;
    }

    final storedSensor = await _db.getSensorState(dateKey);
    if (storedSensor != null) {
      _todayBaseline = storedSensor['baseline_reading'] as int?;
      _lastSensorReading = storedSensor['last_reading'] as int?;
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final status = await Permission.activityRecognition.request();
        if (status.isGranted) {
          statusMessage.value = 'Permission granted. Ready to track.';
          return true;
        } else if (status.isPermanentlyDenied) {
          statusMessage.value = 'Activity Recognition permission permanently denied.';
          return false;
        } else {
          statusMessage.value = 'Activity Recognition permission denied.';
          return false;
        }
      }
    } catch (e) {
      statusMessage.value = 'Permission check skipped or unsupported platform.';
    }
    return true;
  }

  @override
  Future<void> startTracking() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      isTracking.value = false;
      return;
    }

    try {
      statusMessage.value = 'Connecting to motion sensor...';
      _stepCountSubscription?.cancel();

      _stepCountSubscription = Pedometer.stepCountStream.listen(
        _onStepCount,
        onError: _onStepCountError,
        cancelOnError: false,
      );

      isTracking.value = true;
      statusMessage.value = 'Step tracking active';
    } catch (e) {
      isTracking.value = false;
      statusMessage.value = 'Failed to start sensor: $e';
    }
  }

  void _onStepCount(StepCount event) async {
    final dateKey = getTodayDateKey();
    final int currentReading = event.steps;

    // Handle baseline calculation and reboot/reset detection
    if (_todayBaseline == null ||
        (_lastSensorReading != null && currentReading < _lastSensorReading!)) {
      // Sensor reset (e.g. reboot) or new baseline needed
      _todayBaseline = currentReading - currentDailySteps.value;
      if (_todayBaseline! < 0) _todayBaseline = currentReading;
    }

    final int calculatedDailySteps = (currentReading - _todayBaseline!).clamp(0, 1000000);
    _lastSensorReading = currentReading;

    currentDailySteps.value = calculatedDailySteps;
    statusMessage.value = 'Tracking live steps';

    // Persist to local SQLite
    await _db.saveSensorState(dateKey, _todayBaseline!, currentReading);
    await _db.upsertDailySteps(dateKey, calculatedDailySteps);
  }

  void _onStepCountError(dynamic error) {
    statusMessage.value = 'Step sensor error: $error';
    isTracking.value = false;
  }

  @override
  Future<void> stopTracking() async {
    await _stepCountSubscription?.cancel();
    _stepCountSubscription = null;
    isTracking.value = false;
    statusMessage.value = 'Tracking paused';
  }

  @override
  void onClose() {
    stopTracking();
    super.onClose();
  }
}
