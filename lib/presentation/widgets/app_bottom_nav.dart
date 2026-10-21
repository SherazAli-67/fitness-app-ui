import 'package:fitness_app/constants/number_constant.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/asset_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _icons = [
    AssetRes.icHomeUnselected,
    AssetRes.icCalendarUnselected,
    AssetRes.icCaloriesUnselected,
    AssetRes.icProfileUnselected,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: .only(bottom: NumberConstant.bottomNavBottomInset, left: 45, right: 45),
        decoration: BoxDecoration(
          color: AppColors.pureBlackColor,
          borderRadius: .circular(NumberConstant.bottomNavRadius),
        ),
        padding: .all(NumberConstant.bottomNavBarPadding),
        child: Row(
          mainAxisSize: .min,
          mainAxisAlignment: .spaceAround,
          children: List.generate(_icons.length, (index) {
            final isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              behavior: .opaque,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.whiteColor : null,
                  shape: .circle,
                ),
                child: Padding(
                  padding: .all(NumberConstant.bottomNavIconPadding),
                  child: SvgPicture.asset(
                    _icons[index],
                    colorFilter: .mode(isSelected ? AppColors.blackColor : AppColors.whiteColor, .srcIn),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
