import 'package:fitness_app/constants/number_constant.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final ColorFilter? colorFilter;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.whiteColor,
    this.borderColor,
    this.borderWidth = 0,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    final button = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: .circle,
        border: borderColor == null ? null : .all(color: borderColor!, width: borderWidth),
      ),
      child: Padding(
        padding: .all(NumberConstant.circleIconPadding),
        child: SvgPicture.asset(icon, colorFilter: colorFilter,),
      ),
    );
    if (onTap == null) return button;
    return GestureDetector(onTap: onTap, child: button,);
  }
}
