import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_exam_n8/data/local/db/local_database.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/models/product/product.dart';
import '../../../utils/app_colors.dart';

class BoxScreen extends StatefulWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  List<Product> products = [];

  fetch() async {
    products = await LocalDatabase.getAllProducts();
    calculateSumma();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  num summa = 0;

  calculateSumma() {
    summa = 0;
    for (var element in products) {
      summa += element.price * element.count!.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'Basket',
          style: TextStyle(fontSize: 24.spMin, color: AppColors.white),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    title: Text('Delete All',
                        style: TextStyle(
                            color: AppColors.white, fontSize: 24.spMin)),
                    actions: [
                      TextButton(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: AppColors.white, fontSize: 16.spMin)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete',
                            style: TextStyle(
                                color: AppColors.red, fontSize: 20.spMin)),
                        onPressed: () {
                          setState(() {
                            LocalDatabase.delete();
                            calculateSumma();
                            fetch();
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Hammasi o'chirildi",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: AppColors.black,
                              textColor: AppColors.white,
                            );
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.black,
              ),
              child:  Text(
                'Clear',
                style: TextStyle(color: Colors.red,fontSize: 24.spMin),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 570.h,
            width: double.infinity,
            child: ListView(
              children: [
                ...List.generate(products.length, (index) {
                  return ListTile(
                    title: Text(products[index].name,style: TextStyle(fontSize: 22.spMin,color: AppColors.black,fontWeight: FontWeight.w700),),
                    subtitle: Text(
                        "Mahsulotni soni ${products[index].count} x ${products[index].price}",style: TextStyle(fontSize: 16.spMin,color: Colors.blue.withOpacity(0.8)),),
                    trailing: SizedBox(
                      width: 110.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              height: 80.h,
                              width: 80.h,
                              imageUrl: products[index].imageUrl,
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(
                                color: Colors.black,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                          ZoomTapAnimation(
                              onTap: () {
                                setState(() {
                                  LocalDatabase.deleteProduct(
                                      products[index].productId);
                                  calculateSumma();
                                  fetch();
                                  Fluttertoast.showToast(
                                    msg: "O'chirildi",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                });
                              },
                              child: const Icon(Icons.delete,color: AppColors.red,size: 30,)),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          Container(
              margin:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2.r,
                    blurRadius: 5.r,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Jami :',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.spMin),
                  ),
                  Text(
                    "\$ $summa ",
                    style:  TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20.spMin,color: Colors.blueAccent),
                  ),
                ],
              )),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
