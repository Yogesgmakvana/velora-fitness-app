/// Centralized String Constants for VELORA application
class AppStrings {
  AppStrings._();

  // App General
  static const String appName = 'VELORA';

  // Home Screen
  static const String homeTitle = 'Home';
  static const String userSubtitle = 'Sofia you can easily track your progress';
  
  // Dashboard Metrics
  static const String readiness = 'Readiness';
  static const String readinessGoal = '/85 (Goal)';
  
  static const String sleep = 'Sleep';
  static const String sleepValue = '7.4';
  static const String sleepUnit = 'hrs';
  static const String sleepGoal = '/9hrs';
  
  static const String gym = 'Gym';
  static const String thisWeek = 'This week';
  static const String gymProgress = '2/4';

  static const String steps = 'Steps';
  static const String stepsValue = '7,235';
  static const String stepsGoal = '/10,000 Steps';
  
  static const String protein = 'Protein';
  static const String proteinValue = '160';
  static const String proteinGoal = '/300';
  
  static const String calories = 'Calories';
  static const String caloriesValue = '245';
  
  static const String currentWeight = 'Current Weight';

  // Achievements Modal
  static const String achievementsTitle = 'Achievements';
  static const String achievementStepsValue = '10,000';
  static const String achievementStepsLabel = 'Steps';
  static const String hooray = 'Hooray';

  // Steps Detail Screen
  static const String share = 'Share';
  static const String pastWeeks = 'Past weeks';
  static const String goal = 'Goal';
  static const String goalsHitCount = 'Goals Hit #';
  static const String goalsHitCountValue = '2/4';
  static const String days = 'days';
  static const String goalsHitPercent = 'Goal Hit %';
  static const String goalsHitPercentValue = '89';
  static const String percentSymbol = '%';

  // Steps Stats & Tips
  static const String yourStepsStats = 'Your Steps Stats';
  static const String stepsDescription =
      'Increasing your daily step count can contribute to improved overall health and fitness.';
  static const String tipsHeader = 'Here are some tips to help you boost your daily step count:';
  static const String setRealisticGoals = 'Set Realistic Goals:';
  static const String setRealisticGoalsSub =
      'Start with achievable goals and gradually increase your target as your fitness improves.';

  // Days of Week
  static const List<String> weekDayInitials = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  static const List<String> weekDayShortNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
}
