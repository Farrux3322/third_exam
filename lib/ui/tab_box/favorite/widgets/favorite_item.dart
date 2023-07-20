import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/product_model/product_model.dart';
import '../../../../utils/app_colors.dart';
import '../../category_one/widgets/saved_to_box.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key? key, required this.products}) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: products.length,
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
                      padding: EdgeInsets.symmetric(
                          vertical: 8.h, horizontal: 8.w),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              width: 1, color: AppColors.black),
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
                                imageUrl: products[index].imageUrl,
                                placeholder: (context, url) =>
                                    SizedBox(
                                      height: 150.h,
                                      child:
                                      const CupertinoActivityIndicator(
                                        color: AppColors.black,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error,
                                    color: AppColors.red),
                              ),
                            ),
                          ),
                          Text(
                            products[index].name,
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
                                  text: products[index]
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
                          SavedToBox(data: products[index]),
                        ],
                      )),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
