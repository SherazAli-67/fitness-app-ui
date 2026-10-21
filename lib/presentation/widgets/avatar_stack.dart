import 'package:fitness_app/constants/number_constant.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  final List<String> images;
  final double size;
  final double overlap;
  final String? extraCount;

  const AvatarStack({
    super.key,
    required this.images,
    this.size = NumberConstant.activityAvatarSize,
    this.overlap = NumberConstant.activityAvatarOverlap,
    this.extraCount,
  });

  @override
  Widget build(BuildContext context) {
    final countWidth = extraCount == null ? 0.0 : NumberConstant.avatarCountSize;
    final width = size + ((images.length - 1) * overlap) + (extraCount == null ? 0 : overlap) + countWidth;
    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (var i = 0; i < images.length; i++)
            Positioned(
              left: i * overlap,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: AppColors.whiteColor, width: 1.5),
                  image: DecorationImage(image: AssetImage(images[i]), fit: .cover,),
                ),
              ),
            ),
          if (extraCount != null)
            Positioned(
              left: images.length * overlap,
              child: Container(
                width: NumberConstant.avatarCountSize,
                height: NumberConstant.avatarCountSize,
                alignment: .center,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: .circle,
                  border: .all(color: AppColors.avatarBorderColor, width: 1.1),
                ),
                child: Text(extraCount!, style: AppTextStyles.avatarCount,),
              ),
            ),
        ],
      ),
    );
  }
}
