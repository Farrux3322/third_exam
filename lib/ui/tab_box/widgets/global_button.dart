import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/utils/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class GlobalButton extends StatelessWidget {
  const GlobalButton({Key? key, required this.voidCallback}) : super(key: key);

  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: voidCallback,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.black
        ),
        child: Text("Savatchaga qo'shish",style: TextStyle(color: AppColors.white,fontSize: 16.spMin),),
      ),
    );
  }
}
