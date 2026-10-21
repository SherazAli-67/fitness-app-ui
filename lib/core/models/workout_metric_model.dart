import 'package:flutter/material.dart';

class WorkoutMetricModel {
  final String label;
  final String value;
  final String iconSymbol;
  final Color iconBgColor;

  const WorkoutMetricModel({
    required this.label,
    required this.value,
    required this.iconSymbol,
    required this.iconBgColor,
  });
}
