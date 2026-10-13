class StepStatModel {
  final String dayName;
  final int percentage;
  final int stepCount;
  final bool isSelected;

  const StepStatModel({
    required this.dayName,
    required this.percentage,
    required this.stepCount,
    this.isSelected = false,
  });
}
