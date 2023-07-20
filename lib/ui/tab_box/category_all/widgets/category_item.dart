import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/models/category_model/cotegory_model.dart';
import 'package:third_exam_n8/ui/router.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../utils/app_colors.dart';
import '../../category_one/category_one_screen.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.categoryModels}) : super(key: key);

  final List<CategoryModel> categoryModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: categoryModels.length,
            itemBuilder: (context, index) {
              final product = categoryModels[index];
              return ZoomTapAnimation(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryOneScreen(id: product.id,name: product.name,)));
                  Navigator.pushNamed(context, RouteNames.categoryOne, arguments: {
                    "id":product.id,
                    "name":product.name
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                  padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset.zero, // no offset
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: categoryModels[index].imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        const CupertinoActivityIndicator(
                          color: AppColors.black,
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: AppColors.red),
                      ),
                      SizedBox(width: 50.w),
                      Text(
                        product.name,
                        style: TextStyle(
                            fontSize: 20.spMin, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
