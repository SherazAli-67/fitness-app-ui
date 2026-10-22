import 'package:fitness_app/constants/number_constant.dart';
import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/app_data.dart';
import 'package:fitness_app/core/app_textstyles.dart';
import 'package:fitness_app/core/asset_res.dart';
import 'package:fitness_app/core/models/banner_model.dart';
import 'package:fitness_app/core/models/metric_card_model.dart';
import 'package:fitness_app/presentation/screens/home_provider.dart';
import 'package:fitness_app/presentation/widgets/avatar_stack.dart';
import 'package:fitness_app/presentation/widgets/circle_icon_button.dart';
import 'package:fitness_app/presentation/widgets/staggered_entrance.dart';
import 'package:fitness_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => HomeProvider(), child: const _HomeScreenBody(),);
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
          child: Column(
            spacing: NumberConstant.homeSectionSpacing,
            children: [
              Padding(padding: .only(top: 8), child: StaggeredEntrance(index: 0, child: _buildHeader(),),),
              Expanded(
                child: ListView(
                  padding: .only(bottom: NumberConstant.homeBottomContentPadding),
                  children: [
                    Column(
                      spacing: NumberConstant.homeDotsToCategories,
                      children: [
                        StaggeredEntrance(
                          index: 1,
                          child: Column(
                            spacing: NumberConstant.homeBannerToDots,
                            children: [
                              _buildBannerSection(context),
                              _buildPageDots(context),
                            ],
                          ),
                        ),
                        StaggeredEntrance(index: 2, child: _buildCategoryChips(context),),
                        _buildMetricsGrid(context),
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

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Row(
            spacing: 11,
            children: [
              ClipOval(
                child: Image.asset(AssetRes.profileAvatar, height: NumberConstant.headerAvatarSize,),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(StringConst.greetingHello, style: AppTextStyles.greetingLabel,),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: StringConst.greetingName, style: AppTextStyles.greetingName,),
                          TextSpan(text: StringConst.greetingExclaim, style: AppTextStyles.greetingName.copyWith(fontWeight: .w400))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CircleIconButton(icon: AssetRes.icSearch,),
      ],
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    final banner = AppData.banners.first;
    return Stack(
      clipBehavior: .none,
      alignment: .topCenter,
      children: [
        Positioned(
          top: 45,
          left: 20,
          right: 20,
          child: Container(
            height: NumberConstant.bannerAccentHeight,
            decoration: BoxDecoration(color: AppColors.bannerAccentColor, borderRadius: .circular(NumberConstant.bannerRadius),),
          ),
        ),
        _buildBannerCard(context, banner),
      ],
    );
  }

  Widget _buildBannerCard(BuildContext context, BannerModel banner) {
    return Container(
      height: NumberConstant.bannerHeight,
      decoration: BoxDecoration(color: AppColors.bannerBlueColor, borderRadius: .circular(NumberConstant.bannerRadius),),
      clipBehavior: .hardEdge,
      child: Stack(
        children: [
          Positioned.fill(child: SvgPicture.asset(AssetRes.bannerPattern, fit: .cover,)),
          Positioned(
            top: 18,
            right: 18,
            left: 18,
            child: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                Text('${banner.titleLine1}\n${banner.titleLine2}', style: AppTextStyles.bannerTitle,),
                AvatarStack(
                  images: banner.avatarImages,
                  size: NumberConstant.avatarStackSize,
                  overlap: NumberConstant.stackedAvatarOverlap,
                  extraCount: banner.extraCount,
                ),
                _PressScale(
                  onTap: () => context.push(NamedRoutes.activeWorkout.routeName),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: .circular(NumberConstant.bannerCtaRadius),),
                    child: Padding(
                      padding: .only(left: 15, right: 15, top: 10, bottom: 12,),
                      child: Text(banner.ctaLabel, style: AppTextStyles.bannerCta,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 25,
            bottom: 0,
            child: Image.asset(banner.image, fit: .cover,),
          ),
          Positioned(
            top: 10,
            right: 25,
            child: SvgPicture.asset(AssetRes.icBannerClose),
          ),
        ],
      ),
    );
  }

  Widget _buildPageDots(BuildContext context) {
    final page = context.watch<HomeProvider>().bannerPage;
    return Row(
      mainAxisAlignment: .center,
      spacing: NumberConstant.pageDotGap,
      children: List.generate(3, (index) {
        final isActive = page == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: NumberConstant.animFastMs),
          curve: Curves.easeOut,
          width: isActive ? NumberConstant.pageDotSize + 4 : NumberConstant.pageDotSize,
          height: NumberConstant.pageDotSize,
          decoration: BoxDecoration(
            color: isActive ? AppColors.blackColor : AppColors.pageDotInactiveColor,
            borderRadius: .circular(NumberConstant.pageDotSize),
          ),
        );
      },),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final selectedIndex = context.watch<HomeProvider>().selectedCategoryIndex;
    return Container(
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: .circular(NumberConstant.categoryBarRadius),),
      padding: .all(NumberConstant.categoryBarPadding),
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          children: List.generate(AppData.categories.length, (index) {
            final isSelected = selectedIndex == index;
            final category = AppData.categories[index].label;
            return GestureDetector(
              onTap: () => context.read<HomeProvider>().selectCategory(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: NumberConstant.animFastMs),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.chipSelectedColor : Colors.transparent,
                  borderRadius: .circular(NumberConstant.categoryChipRadius),
                ),
                padding: .symmetric(horizontal: isSelected ? 20 : 13, vertical: 12,),
                child: Text(category, style: AppTextStyles.headingH3,),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return Column(
      spacing: NumberConstant.metricRowGap,
      children: [
        Row(
          spacing: NumberConstant.metricGridGap,
          children: [
            Expanded(child: StaggeredEntrance(index: 3, child: _buildMetricCard(AppData.metricCards[0]),),),
            Expanded(child: StaggeredEntrance(index: 4, child: _buildMetricCard(AppData.metricCards[1]),),),
          ],
        ),
        Row(
          spacing: NumberConstant.metricGridGap,
          crossAxisAlignment: .start,
          children: [
            Expanded(child: StaggeredEntrance(index: 5, child: _buildMetricCard(AppData.metricCards[2]),),),
            Expanded(child: StaggeredEntrance(index: 6, child: _buildAddActivityCard(context),),),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(MetricCardModel metric) {
    return Container(
      height: NumberConstant.metricCardHeight,
      padding: .all(NumberConstant.metricCardPadding),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: .circular(NumberConstant.metricCardRadius),),
      child: Column(
        spacing: 11,
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: .only(left: 4, top: 4,),
            child: Row(
              spacing: 6,
              children: [
                Stack(
                  alignment: .center,
                  children: [
                    SvgPicture.asset(_metricIconBg(metric.chartKind), width: NumberConstant.metricIconSize, height: NumberConstant.metricIconSize,),
                    Text(metric.iconSymbol, style: TextStyle(fontSize: metric.chartKind == .line ? 16 : 14),)
                  ],
                ),
                Text(metric.title, style: AppTextStyles.metricTitle,)
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: metric.accentColor, borderRadius: .circular(NumberConstant.metricInnerRadius),),
              clipBehavior: .hardEdge,
              child: Stack(
                children: [
                  Positioned.fill(child: _buildMetricChart(metric),),
                  Positioned(
                    left: 13,
                    bottom: 19,
                    child: Row(
                      crossAxisAlignment: .end,
                      children: [
                        Text(metric.value, style: AppTextStyles.metricValue,),
                        Padding(
                          padding: .only(bottom: 2,),
                          child: Text(metric.unit, style: AppTextStyles.metricUnit,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _metricIconBg(MetricChartKind kind) => switch (kind) {
    .line => AssetRes.icMetricStepsBg,
    .bars => AssetRes.icMetricCaloriesBg,
    .wave => AssetRes.icMetricHeartBg,
  };

  Widget _buildMetricChart(MetricCardModel metric) => switch (metric.chartKind) {
    .line => Stack(
      fit: .expand,
      children: [
        Positioned(left: 0, right: 0, bottom: 0, height: 128, child: SvgPicture.asset(AssetRes.stepsChartFill, fit: .fill,),),
        Positioned(left: -2, right: -2, bottom: 71, height: 56, child: SvgPicture.asset(AssetRes.stepsChartLine, fit: .fill,),),
      ],
    ),
    .bars => Stack(
      fit: .expand,
      children: [
        Positioned.fill(child: SvgPicture.asset(AssetRes.caloriesChartBg, fit: .fill,),),
        Positioned(left: 19, right: 19, top: 20, height: 62, child: _AnimatedCaloriesBars(),),
      ],
    ),
    .wave => Stack(
      fit: .expand,
      children: [
        Positioned(left: 0, right: 0, bottom: 0, height: 120, child: SvgPicture.asset(AssetRes.heartChartFill, fit: .fill,),),
        Positioned(left: -2, right: -2, bottom: 71, height: 50, child: SvgPicture.asset(AssetRes.heartChartLine, fit: .fill,),),
      ],
    ),
  };

  Widget _buildAddActivityCard(BuildContext context) {
    return _PressScale(
      onTap: () => context.push(NamedRoutes.activeWorkout.routeName),
      child: Container(
        height: NumberConstant.addActivityCardHeight,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: .circular(NumberConstant.addActivityCardRadius),
          border: .all(color: AppColors.borderColor, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: .center,
          spacing: 5,
          children: [
            SvgPicture.asset(AssetRes.icAddCircle, height: 35,),
            Text(StringConst.addActivity, style: AppTextStyles.bodyB2,),
          ],
        ),
      ),
    );
  }
}

class _PressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PressScale({required this.child, required this.onTap,});

  @override
  State<_PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<_PressScale> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? NumberConstant.animPressScale : 1,
        duration: const Duration(milliseconds: NumberConstant.animFastMs),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class _AnimatedCaloriesBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: disableAnimations ? 1 : 0, end: 1),
      duration: Duration(milliseconds: disableAnimations ? 0 : NumberConstant.animEntranceMs),
      curve: Curves.easeOutCubic,
      builder: (context, progress, _) => CustomPaint(painter: _CaloriesBarPainter(progress: progress),),
    );
  }
}

class _CaloriesBarPainter extends CustomPainter {
  final double progress;

  static const _heights = [48.0, 31.0, 26.0, 29.0, 44.0, 43.0, 34.0, 34.0, 28.0, 51.0];

  _CaloriesBarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.calorieBarColor;
    final gap = NumberConstant.calorieBarGap;
    final barWidth = NumberConstant.calorieBarWidth;
    final totalWidth = (_heights.length * barWidth) + ((_heights.length - 1) * gap);
    var x = (size.width - totalWidth) / 2;
    for (final height in _heights) {
      final animatedHeight = height * progress;
      final top = size.height - animatedHeight;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, top, barWidth, animatedHeight), const Radius.circular(25),),
        paint,
      );
      x += barWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _CaloriesBarPainter oldDelegate) => oldDelegate.progress != progress;
}
