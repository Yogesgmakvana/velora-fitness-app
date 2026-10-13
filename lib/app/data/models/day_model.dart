import 'package:flutter/material.dart';

class DayModel {
  final String initial;
  final int dateNumber;
  final DateTime? fullDate;
  final bool isSelected;
  final bool isCompleted;
  final Color? ringColor;

  const DayModel({
    required this.initial,
    required this.dateNumber,
    this.fullDate,
    this.isSelected = false,
    this.isCompleted = false,
    this.ringColor,
  });

  DayModel copyWith({
    String? initial,
    int? dateNumber,
    DateTime? fullDate,
    bool? isSelected,
    bool? isCompleted,
    Color? ringColor,
  }) {
    return DayModel(
      initial: initial ?? this.initial,
      dateNumber: dateNumber ?? this.dateNumber,
      fullDate: fullDate ?? this.fullDate,
      isSelected: isSelected ?? this.isSelected,
      isCompleted: isCompleted ?? this.isCompleted,
      ringColor: ringColor ?? this.ringColor,
    );
  }
}
