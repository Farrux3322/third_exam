import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/ui/tab_box/category_one/widgets/saved_to_box.dart';
import 'package:third_exam_n8/utils/app_colors.dart';

import '../../../../data/models/product_model/product_model.dart';
import 'like_item.dart';

class CategoryDetailItem extends StatelessWidget {
  const CategoryDetailItem({Key? key, required this.productModels, required this.likes}) : super(key: key);

  final List<ProductModel> productModels;
  final List<int> likes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: productModels.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          border:
                          Border.all(width: 1, color:AppColors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 7,
                              spreadRadius: 1,
                              offset: const Offset(3, 3),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: SizedBox(
                              height: 150.h,
                              child: CachedNetworkImage(
                                imageUrl:
                                productModels[index].imageUrl,
                                placeholder: (context, url) => SizedBox(
                                  height: 150.h,
                                  child: const CupertinoActivityIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                          Text(
                            productModels[index].name,
                            style: TextStyle(
                                fontSize: 20.spMin,
                                fontWeight: FontWeight.w500),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "USD  ",
                              style: TextStyle(
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                              children: [
                                TextSpan(
                                  text: productModels[index]
                                      .price
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20.spMin,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),

                          SavedToBox(data: productModels[index])
                        ],
                      )),
                  Positioned(
                    right: 20.w,
                    top: 10.h,
                    child: Container(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Center(
                          child: LikeItem(
                            productModel: productModels[index],
                            isLike:
                            likes.contains(productModels[index].id),
                          )),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
