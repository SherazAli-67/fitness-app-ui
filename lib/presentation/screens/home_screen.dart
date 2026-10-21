import 'package:fitness_app/constants/string_const.dart';
import 'package:fitness_app/core/app_colors.dart';
import 'package:fitness_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: Center(child: Text(StringConst.appTitle, style: AppTextStyles.sectionTitle,),),
    );
  }
}
