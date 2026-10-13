import '../../core/constants/app_colors.dart';
import '../models/day_model.dart';
import '../models/step_stat_model.dart';

class FitnessDataProvider {
  /// Dynamically computes real current week dates (Sun - Sat) based on device clock
  static List<DayModel> getWeekDays() {
    final now = DateTime.now();
    final int currentWeekdayIndex = now.weekday % 7; // Sun=0, Mon=1, Tue=2, ..., Sat=6
    final DateTime startOfWeek = now.subtract(Duration(days: currentWeekdayIndex));

    final initials = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final List<DayModel> days = [];

    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      final bool isToday = date.year == now.year && date.month == now.month && date.day == now.day;
      final bool isPast = date.isBefore(DateTime(now.year, now.month, now.day));

      days.add(
        DayModel(
          initial: initials[i],
          dateNumber: date.day,
          fullDate: date,
          isSelected: isToday,
          isCompleted: isPast,
          ringColor: isToday
              ? AppColors.primaryNeon
              : (isPast ? AppColors.gymTeal : AppColors.cardBorder),
        ),
      );
    }

    return days;
  }

  static List<DayModel> getStepsWeekDays() {
    return getWeekDays();
  }

  static List<StepStatModel> getWeeklyStepStats() {
    final now = DateTime.now();
    final dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final List<StepStatModel> stats = [];

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayName = dayNames[date.weekday % 7];

      stats.add(
        StepStatModel(
          dayName: dayName,
          percentage: i == 0 ? 75 : (i % 2 == 0 ? 102 : 45),
          stepCount: i == 0 ? 7500 : (i % 2 == 0 ? 10200 : 4500),
          isSelected: i == 0,
        ),
      );
    }

    return stats;
  }
}
