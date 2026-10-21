import 'package:flutter/material.dart';

class DailyActivityModel {
  final String time;
  final String title;
  final String value;
  final String goalLabel;
  final Color accentColor;
  final List<String> avatarImages;

  const DailyActivityModel({
    required this.time,
    required this.title,
    required this.value,
    required this.goalLabel,
    required this.accentColor,
    required this.avatarImages,
  });
}
