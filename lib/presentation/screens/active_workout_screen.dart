import 'dart:ui';

import 'package:fitness_app/constants/number_constant.dart';
import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/app_data.dart';
import 'package:fitness_app/core/app_textstyles.dart';
import 'package:fitness_app/core/asset_res.dart';
import 'package:fitness_app/core/models/workout_metric_model.dart';
import 'package:fitness_app/presentation/screens/active_workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ActiveWorkoutScreen extends StatelessWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ActiveWorkoutProvider(), child: const _ActiveWorkoutBody(),);
  }
}

class _ActiveWorkoutBody extends StatelessWidget {
  const _ActiveWorkoutBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(child: Image.asset(AssetRes.workoutGymImg, fit: .cover, alignment: const Alignment(0.15, -0.1),),),
          Positioned(
            left: 0,
            right: 0,
            bottom: NumberConstant.workoutSheetHeight - NumberConstant.workoutProgressHeight,
            height: NumberConstant.workoutGradientHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [AppColors.workoutGradientColor.withValues(alpha: 0), AppColors.workoutGradientColor,],
                  stops: const [0.07, 0.65],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Align(
              alignment: .topLeft,
              child: Padding(
                padding: .only(left: NumberConstant.horizontalPadding, top: 8,),
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: .circle,
                      border: .all(color: AppColors.lightBorderColor, width: NumberConstant.workoutBackBorderWidth),
                    ),
                    child: Padding(
                      padding: .all(NumberConstant.circleIconPadding),
                      child: SvgPicture.asset(AssetRes.icBackWhite,),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: NumberConstant.workoutAlertTop,
            right: NumberConstant.workoutAlertRight,
            child: _buildHeartRateAlert(),
          ),
          Align(alignment: .bottomCenter, child: _buildBottomSheet(context),),
        ],
      ),
    );
  }

  Widget _buildHeartRateAlert() {
    return ClipRRect(
      borderRadius: .circular(NumberConstant.workoutAlertRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: NumberConstant.workoutAlertBlur, sigmaY: NumberConstant.workoutAlertBlur,),
        child: Container(
          width: NumberConstant.workoutAlertWidth,
          padding: .symmetric(horizontal: NumberConstant.workoutAlertHPadding, vertical: NumberConstant.workoutAlertVPadding,),
          decoration: BoxDecoration(
            color: AppColors.glassBgColor,
            borderRadius: .circular(NumberConstant.workoutAlertRadius),
            border: .all(color: AppColors.glassBorderColor),
          ),
          child: Row(
            spacing: NumberConstant.workoutAlertIconGap,
            children: [
              SvgPicture.asset(AssetRes.icHeartPulse,),
              Expanded(child: Text(StringConst.heartRateAlert, style: AppTextStyles.workoutAlert,),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.scaffoldBgColor,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: .min,
          children: [
            _buildProgressBar(),
            Padding(
              padding: .fromLTRB(NumberConstant.workoutMetricsHPadding, NumberConstant.workoutMetricsTopPadding, NumberConstant.workoutMetricsHPadding, 16,),
              child: Column(
                spacing: NumberConstant.workoutTimerTopGap,
                children: [
                  _buildMetricsRow(),
                  Column(
                    spacing: NumberConstant.workoutControlsTopGap,
                    children: [
                      Text(AppData.workoutTimer, style: AppTextStyles.workoutTimer, textAlign: .center,),
                      _buildControls(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      height: NumberConstant.workoutProgressHeight,
      width: double.infinity,
      child: Stack(
        fit: .expand,
        children: [
          const ColoredBox(color: AppColors.progressFillColor),
          FractionallySizedBox(
            alignment: .centerLeft,
            widthFactor: AppData.workoutProgress,
            child: const ColoredBox(color: AppColors.progressTrackColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsRow() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: AppData.workoutMetrics.map(_buildMetricItem).toList(),
    );
  }

  Widget _buildMetricItem(WorkoutMetricModel metric) {
    return Row(
      spacing: NumberConstant.workoutMetricGap,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: metric.iconBgColor, borderRadius: .circular(NumberConstant.workoutMetricIconRadius),),
          child: Padding(
            padding: .all(10),
            child: Text(metric.iconSymbol, style: const TextStyle(fontSize: 20, height: 1,),),
          ),
        ),
        Column(
          spacing: NumberConstant.workoutMetricGap,
          crossAxisAlignment: .start,
          children: [
            Text(metric.label, style: AppTextStyles.workoutMetricLabel,),
            Text(metric.value, style: AppTextStyles.workoutMetricValue,),
          ],
        ),
      ],
    );
  }

  Widget _buildControls(BuildContext context) {
    final isPaused = context.watch<ActiveWorkoutProvider>().isPaused;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Text(StringConst.cancel, style: AppTextStyles.workoutCancel, textAlign: .center,),
          ),
        ),
        GestureDetector(
          onTap: () => context.read<ActiveWorkoutProvider>().togglePause(),
          child: DecoratedBox(
            decoration: BoxDecoration(color: AppColors.pureBlackColor, borderRadius: .circular(NumberConstant.workoutPauseRadius),),
            child: Padding(
              padding: .all(NumberConstant.workoutPausePadding),
              child: isPaused
                  ? Icon(Icons.play_arrow_rounded, color: AppColors.whiteColor, size: 17,)
                  : SvgPicture.asset(AssetRes.icPause,),
            ),
          ),
        ),
        Expanded(child: Text(StringConst.next, style: AppTextStyles.workoutNext, textAlign: .center,),),
      ],
    );
  }
}
