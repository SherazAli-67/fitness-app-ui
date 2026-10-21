import 'package:flutter/material.dart';

enum MetricChartKind { line, bars, wave }

class MetricCardModel {
  final String title;
  final String value;
  final String unit;
  final String iconSymbol;
  final Color accentColor;
  final MetricChartKind chartKind;

  const MetricCardModel({
    required this.title,
    required this.value,
    required this.unit,
    required this.iconSymbol,
    required this.accentColor,
    required this.chartKind,
  });
}
