import 'dart:math' as math;

import 'package:fitness_app/constants/number_constant.dart';
import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/app_data.dart';
import 'package:fitness_app/core/app_textstyles.dart';
import 'package:fitness_app/core/asset_res.dart';
import 'package:fitness_app/core/models/calendar_day_model.dart';
import 'package:fitness_app/core/models/daily_activity_model.dart';
import 'package:fitness_app/presentation/screens/activity_provider.dart';
import 'package:fitness_app/presentation/widgets/avatar_stack.dart';
import 'package:fitness_app/presentation/widgets/circle_icon_button.dart';
import 'package:fitness_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ActivityProvider(), child: const _ActivityScreenBody(),);
  }
}

class _ActivityScreenBody extends StatelessWidget {
  const _ActivityScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
          child: Column(
            spacing: NumberConstant.activitySectionGap,
            children: [
              Padding(padding: .only(top: 8), child: _buildHeader(context),),
              Expanded(
                child: ListView(
                  padding: .only(bottom: NumberConstant.activityBottomContentPadding),
                  children: [
                    Column(
                      spacing: NumberConstant.activitySectionGap,
                      children: [
                        _buildCalendarCard(context),
                        _buildDailyActivitiesHeader(),
                        _buildDailyActivitiesList(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleIconButton(icon: AssetRes.icBack, onTap: () => context.go(NamedRoutes.home.routeName),),
        Expanded(child: Text(StringConst.myActivity, style: AppTextStyles.headingH2, textAlign: .center,),),
        CircleIconButton(icon: AssetRes.icSearch,),
      ],
    );
  }

  Widget _buildCalendarCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .symmetric(horizontal: NumberConstant.calendarCardHPadding, vertical: NumberConstant.calendarCardVPadding,),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: .circular(NumberConstant.calendarCardRadius),),
      child: Column(
        spacing: NumberConstant.calendarHeaderGap,
        children: [
          Row(
            children: [
              Text(StringConst.calendarYear, style: AppTextStyles.calendarYear,),
              Spacer(),
              Row(
                spacing: 7,
                children: [
                  Text(StringConst.calendarMonth, style: AppTextStyles.calendarMonth,),
                  SvgPicture.asset(AssetRes.icChevronDown,),
                ],
              ),
            ],
          ),
          Column(
            spacing: NumberConstant.calendarGridGap,
            children: [
              _buildWeekdayRow(),
              _buildDaysGrid(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayRow() {
    return Row(
      children: List.generate(AppData.weekdays.length, (index) {
        final isActive = index == AppData.activeWeekdayIndex;
        return Expanded(
          child: Center(
            child: Text(AppData.weekdays[index], style: isActive ? AppTextStyles.calendarWeekdayActive : AppTextStyles.calendarWeekday,),
          ),
        );
      }),
    );
  }

  Widget _buildDaysGrid(BuildContext context) {
    final selectedIndex = context.watch<ActivityProvider>().selectedDayIndex;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppData.calendarDays.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: NumberConstant.calendarDayGap,
        crossAxisSpacing: NumberConstant.calendarDayGap,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => _buildDayCell(context, AppData.calendarDays[index], index == selectedIndex, index,),
    );
  }

  Widget _buildDayCell(BuildContext context, CalendarDayModel day, bool isSelected, int index) {
    final content = Center(child: Text('${day.day}', style: AppTextStyles.calendarDay,),);
    if (!day.inMonth) {
      return GestureDetector(
        onTap: () => context.read<ActivityProvider>().selectDay(index),
        child: CustomPaint(painter: _DashedCirclePainter(), child: content,),
      );
    }
    return GestureDetector(
      onTap: () => context.read<ActivityProvider>().selectDay(index),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.calendarSelectedColor : AppColors.calendarDayBgColor,
          shape: .circle,
        ),
        child: content,
      ),
    );
  }

  Widget _buildDailyActivitiesHeader() {
    return Row(
      children: [
        Expanded(child: Text(StringConst.dailyActivities, style: AppTextStyles.sectionTitle,),),
        Text(StringConst.seeAll, style: AppTextStyles.seeAllUnderline,),
      ],
    );
  }

  Widget _buildDailyActivitiesList() {
    return Column(
      spacing: NumberConstant.activityListGap,
      children: AppData.dailyActivities.map(_buildActivityRow).toList(),
    );
  }

  Widget _buildActivityRow(DailyActivityModel activity) {
    return Row(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        SizedBox(
          width: NumberConstant.activityTimeWidth,
          child: Text(activity.time, style: AppTextStyles.activityTime,),
        ),
        Expanded(child: _buildActivityCard(activity),),
      ],
    );
  }

  Widget _buildActivityCard(DailyActivityModel activity) {
    return Container(
      height: NumberConstant.activityCardHeight,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: .circular(NumberConstant.activityCardRadius),),
      clipBehavior: .hardEdge,
      child: Row(
        children: [
          Container(width: NumberConstant.activityAccentWidth, color: activity.accentColor,),
          Expanded(
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.activityCardHPadding,),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      spacing: 12,
                      children: [
                        Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .start,
                          children: [
                            Text(activity.title, style: AppTextStyles.activityTitle,),
                            Text(activity.value, style: AppTextStyles.activityValue,),
                          ],
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(color: activity.accentColor, borderRadius: .circular(NumberConstant.activityGoalRadius),),
                          child: Padding(
                            padding: .symmetric(horizontal: 7, vertical: 7,),
                            child: Text(activity.goalLabel, style: AppTextStyles.activityGoal,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AvatarStack(images: activity.avatarImages,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blackColor
      ..style = .stroke
      ..strokeWidth = 1;
    final radius = (size.shortestSide / 2) - 0.5;
    final center = Offset(size.width / 2, size.height / 2);
    const dashAngle = 0.18;
    const gapAngle = 0.12;
    var start = 0.0;
    while (start < math.pi * 2) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start, dashAngle, false, paint,);
      start += dashAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
