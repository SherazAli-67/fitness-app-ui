import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: Center(child: Text(StringConst.profileScreen, style: AppTextStyles.sectionTitle,),),
    );
  }
}
