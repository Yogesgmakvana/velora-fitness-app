import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/step_stat_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDB('velora_fitness_v2.db');
      return _database;
    } catch (e) {
      return null;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE daily_activity (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date_key TEXT UNIQUE NOT NULL,
        steps INTEGER NOT NULL DEFAULT 0,
        step_goal INTEGER NOT NULL DEFAULT 10000,
        sleep_hours REAL NOT NULL DEFAULT 7.4,
        sleep_goal REAL NOT NULL DEFAULT 9.0,
        gym_completed INTEGER NOT NULL DEFAULT 2,
        gym_total INTEGER NOT NULL DEFAULT 4,
        protein INTEGER NOT NULL DEFAULT 160,
        protein_goal INTEGER NOT NULL DEFAULT 300,
        calories INTEGER NOT NULL DEFAULT 245,
        readiness INTEGER NOT NULL DEFAULT 92,
        weight_kg REAL NOT NULL DEFAULT 62.5,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE sensor_state (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date_key TEXT UNIQUE NOT NULL,
        baseline_reading INTEGER NOT NULL DEFAULT 0,
        last_reading INTEGER NOT NULL DEFAULT 0,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE weight_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight_kg REAL NOT NULL,
        logged_at TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS daily_activity');
      await db.execute('DROP TABLE IF EXISTS sensor_state');
      await db.execute('DROP TABLE IF EXISTS weight_entries');
      await _createDB(db, newVersion);
    }
  }

  /// Retrieve full daily summary for a date (YYYY-MM-DD)
  Future<Map<String, dynamic>?> getDailyActivity(String dateKey) async {
    final db = await database;
    if (db == null) return null;

    final result = await db.query(
      'daily_activity',
      where: 'date_key = ?',
      whereArgs: [dateKey],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  /// Convenience wrapper for step tracking
  Future<void> upsertDailySteps(String dateKey, int steps, {int stepGoal = 10000}) async {
    await upsertDailyMetrics(dateKey: dateKey, steps: steps, stepGoal: stepGoal);
  }

  /// Upsert full activity metrics for a specific date
  Future<void> upsertDailyMetrics({
    required String dateKey,
    int? steps,
    int? stepGoal,
    double? sleepHours,
    double? sleepGoal,
    int? gymCompleted,
    int? gymTotal,
    int? protein,
    int? proteinGoal,
    int? calories,
    int? readiness,
    double? weightKg,
  }) async {
    final db = await database;
    if (db == null) return;

    final existing = await getDailyActivity(dateKey);
    final now = DateTime.now().toIso8601String();

    final int currentSteps = steps ?? (existing?['steps'] as int?) ?? 0;
    final int currentStepGoal = stepGoal ?? (existing?['step_goal'] as int?) ?? 10000;
    final double currentSleepHours = sleepHours ?? (existing?['sleep_hours'] as double?) ?? 7.4;
    final double currentSleepGoal = sleepGoal ?? (existing?['sleep_goal'] as double?) ?? 9.0;
    final int currentGymComp = gymCompleted ?? (existing?['gym_completed'] as int?) ?? 2;
    final int currentGymTot = gymTotal ?? (existing?['gym_total'] as int?) ?? 4;
    final int currentProtein = protein ?? (existing?['protein'] as int?) ?? 160;
    final int currentProteinGoal = proteinGoal ?? (existing?['protein_goal'] as int?) ?? 300;
    final int currentCalories = calories ?? (existing?['calories'] as int?) ?? 245;
    final int currentReadiness = readiness ?? (existing?['readiness'] as int?) ?? 92;
    final double currentWeight = weightKg ?? (existing?['weight_kg'] as double?) ?? 62.5;

    await db.rawInsert('''
      INSERT INTO daily_activity (
        date_key, steps, step_goal, sleep_hours, sleep_goal,
        gym_completed, gym_total, protein, protein_goal,
        calories, readiness, weight_kg, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(date_key) DO UPDATE SET
        steps = ?, step_goal = ?, sleep_hours = ?, sleep_goal = ?,
        gym_completed = ?, gym_total = ?, protein = ?, protein_goal = ?,
        calories = ?, readiness = ?, weight_kg = ?, updated_at = ?
    ''', [
      dateKey, currentSteps, currentStepGoal, currentSleepHours, currentSleepGoal,
      currentGymComp, currentGymTot, currentProtein, currentProteinGoal,
      currentCalories, currentReadiness, currentWeight, now, now,
      currentSteps, currentStepGoal, currentSleepHours, currentSleepGoal,
      currentGymComp, currentGymTot, currentProtein, currentProteinGoal,
      currentCalories, currentReadiness, currentWeight, now,
    ]);
  }

  /// Store sensor baseline state
  Future<Map<String, dynamic>?> getSensorState(String dateKey) async {
    final db = await database;
    if (db == null) return null;

    final result = await db.query(
      'sensor_state',
      where: 'date_key = ?',
      whereArgs: [dateKey],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<void> saveSensorState(String dateKey, int baseline, int lastReading) async {
    final db = await database;
    if (db == null) return;

    final now = DateTime.now().toIso8601String();

    await db.rawInsert('''
      INSERT INTO sensor_state (date_key, baseline_reading, last_reading, updated_at)
      VALUES (?, ?, ?, ?)
      ON CONFLICT(date_key) DO UPDATE SET
        baseline_reading = ?,
        last_reading = ?,
        updated_at = ?
    ''', [dateKey, baseline, lastReading, now, baseline, lastReading, now]);
  }

  /// Log weight entry in history table
  Future<void> insertWeightEntry(double weightKg) async {
    final db = await database;
    if (db == null) return;

    await db.insert('weight_entries', {
      'weight_kg': weightKg,
      'logged_at': DateTime.now().toIso8601String(),
    });
  }

  /// Retrieve last 7 days of step stats
  Future<List<StepStatModel>> getWeeklyStepStats() async {
    final db = await database;
    if (db == null) return [];

    final now = DateTime.now();
    final List<StepStatModel> stats = [];

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      
      final dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      final dayName = dayNames[date.weekday % 7];

      final result = await db.query(
        'daily_activity',
        where: 'date_key = ?',
        whereArgs: [dateKey],
      );

      int steps = 0;
      int goal = 10000;

      if (result.isNotEmpty) {
        steps = (result.first['steps'] as int?) ?? 0;
        goal = (result.first['step_goal'] as int?) ?? 10000;
      }

      final percentage = goal > 0 ? ((steps / goal) * 100).round() : 0;

      stats.add(
        StepStatModel(
          dayName: dayName,
          percentage: percentage,
          stepCount: steps,
          isSelected: i == 0,
        ),
      );
    }

    return stats;
  }
}
