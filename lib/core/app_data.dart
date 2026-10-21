import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/asset_res.dart';
import 'package:fitness_app/core/models/banner_model.dart';
import 'package:fitness_app/core/models/calendar_day_model.dart';
import 'package:fitness_app/core/models/category_model.dart';
import 'package:fitness_app/core/models/daily_activity_model.dart';
import 'package:fitness_app/core/models/metric_card_model.dart';
import 'package:fitness_app/core/models/workout_metric_model.dart';

class AppData {
  static const stackedAvatars = [
    AssetRes.avatar1,
    AssetRes.avatar2,
    AssetRes.avatar3,
    AssetRes.avatar4,
  ];

  static const banners = [
    BannerModel(
      titleLine1: StringConst.bannerTitleLine1,
      titleLine2: StringConst.bannerTitleLine2,
      ctaLabel: StringConst.joinToday,
      image: AssetRes.bannerCycling,
      avatarImages: stackedAvatars,
      extraCount: StringConst.avatarExtraCount,
    ),
  ];

  static const categories = [
    CategoryModel(label: StringConst.categoryAll),
    CategoryModel(label: StringConst.categoryCardio),
    CategoryModel(label: StringConst.categoryMuscle),
    CategoryModel(label: StringConst.categoryWeight),
    CategoryModel(label: StringConst.categoryDieting),
  ];

  static const metricCards = [
    MetricCardModel(
      title: StringConst.steps,
      value: '1,100',
      unit: StringConst.steps,
      iconSymbol: StringConst.stepsIconSymbol,
      accentColor: AppColors.stepsCardColor,
      chartKind: .line,
    ),
    MetricCardModel(
      title: StringConst.calories,
      value: '900',
      unit: StringConst.kcal,
      iconSymbol: StringConst.caloriesBurnSymbol,
      accentColor: AppColors.caloriesCardColor,
      chartKind: .bars,
    ),
    MetricCardModel(
      title: StringConst.heartRate,
      value: '135',
      unit: StringConst.steps,
      iconSymbol: StringConst.heartRateSymbol,
      accentColor: AppColors.heartRateCardColor,
      chartKind: .wave,
    ),
  ];

  static const weekdays = [
    StringConst.weekdaySu,
    StringConst.weekdayMo,
    StringConst.weekdayTu,
    StringConst.weekdayWe,
    StringConst.weekdayTh,
    StringConst.weekdayFr,
    StringConst.weekdaySa,
  ];

  static const calendarDays = [
    CalendarDayModel(day: 29, inMonth: false),
    CalendarDayModel(day: 30, inMonth: false),
    CalendarDayModel(day: 1, inMonth: true),
    CalendarDayModel(day: 2, inMonth: true),
    CalendarDayModel(day: 3, inMonth: true),
    CalendarDayModel(day: 4, inMonth: true, isSelected: true),
    CalendarDayModel(day: 5, inMonth: true),
    CalendarDayModel(day: 6, inMonth: true),
    CalendarDayModel(day: 7, inMonth: true),
    CalendarDayModel(day: 8, inMonth: true),
    CalendarDayModel(day: 9, inMonth: true),
    CalendarDayModel(day: 10, inMonth: true),
    CalendarDayModel(day: 11, inMonth: true),
    CalendarDayModel(day: 12, inMonth: true),
    CalendarDayModel(day: 13, inMonth: true),
    CalendarDayModel(day: 14, inMonth: true),
    CalendarDayModel(day: 15, inMonth: true),
    CalendarDayModel(day: 16, inMonth: true),
    CalendarDayModel(day: 17, inMonth: true),
    CalendarDayModel(day: 18, inMonth: true),
    CalendarDayModel(day: 19, inMonth: true),
    CalendarDayModel(day: 20, inMonth: true),
    CalendarDayModel(day: 21, inMonth: true),
    CalendarDayModel(day: 22, inMonth: true),
    CalendarDayModel(day: 23, inMonth: true),
    CalendarDayModel(day: 24, inMonth: true),
    CalendarDayModel(day: 25, inMonth: true),
    CalendarDayModel(day: 26, inMonth: true),
    CalendarDayModel(day: 27, inMonth: true),
    CalendarDayModel(day: 28, inMonth: true),
    CalendarDayModel(day: 29, inMonth: true),
    CalendarDayModel(day: 30, inMonth: true),
    CalendarDayModel(day: 31, inMonth: true),
    CalendarDayModel(day: 1, inMonth: false),
    CalendarDayModel(day: 2, inMonth: false),
  ];

  static const activeWeekdayIndex = 5;

  static const dailyActivities = [
    DailyActivityModel(
      time: '10.00 AM',
      title: StringConst.activityRunning,
      value: '3.2 km',
      goalLabel: 'Goal 2.5 km',
      accentColor: AppColors.activityRunningAccent,
      avatarImages: [AssetRes.avatar2, AssetRes.avatar3, AssetRes.avatar4],
    ),
    DailyActivityModel(
      time: '11.00 AM',
      title: StringConst.activityWeight,
      value: '150 lbs',
      goalLabel: 'Goal 160 lbs',
      accentColor: AppColors.activityWeightAccent,
      avatarImages: [AssetRes.avatar3, AssetRes.avatar4],
    ),
    DailyActivityModel(
      time: '12.00 PM',
      title: StringConst.activityMuscle,
      value: '1:30 hr',
      goalLabel: 'Goal 1:50 hr',
      accentColor: AppColors.activityMuscleAccent,
      avatarImages: stackedAvatars,
    ),
  ];

  static const workoutMetrics = [
    WorkoutMetricModel(
      label: StringConst.calories,
      value: '150',
      iconSymbol: StringConst.caloriesBurnSymbol,
      iconBgColor: AppColors.caloriesIconBgColor,
    ),
    WorkoutMetricModel(
      label: StringConst.time,
      value: '55:00',
      iconSymbol: StringConst.icTimeClockSymbol,
      iconBgColor: AppColors.stepsCardColor,
    ),
    WorkoutMetricModel(
      label: StringConst.heartRate,
      value: '185',
      iconSymbol: StringConst.heartRateSymbol,
      iconBgColor: AppColors.heartRateCardColor,
    ),
  ];

  static const workoutTimer = StringConst.workoutTimer;
  static const workoutProgress = 0.75;
}
