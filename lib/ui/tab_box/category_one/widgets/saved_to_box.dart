import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_exam_n8/data/local/db/local_database.dart';
import 'package:third_exam_n8/data/models/product_model/product_model.dart';
import 'package:third_exam_n8/utils/app_colors.dart';

import '../../../../data/models/product/product.dart';

// ignore: must_be_immutable
class SavedToBox extends StatefulWidget {
  ProductModel data;

  SavedToBox({super.key, required this.data});

  @override
  State<SavedToBox> createState() => _SavedToBoxState();
}

class _SavedToBoxState extends State<SavedToBox> {
  bool isAddingToCart = false;

  @override
  Widget build(BuildContext context) {
    ProductModel data = widget.data;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      onPressed: isAddingToCart ? null
          : () async {
              setState(() {
                isAddingToCart = true;
              });

              Fluttertoast.showToast(
                msg: "Savatchaga qo'shildi",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              );

              Product? product =
                  await LocalDatabase().getProductById(data.id.toString());
              if (product != null) {
                await LocalDatabase.updateProduct(
                  Product(
                    productId: product.productId,
                    count: product.count! + 1,
                    name: product.name,
                    price: product.price,
                    imageUrl: product.imageUrl,
                  ),
                );
              } else {
                await LocalDatabase.insertProduct(
                  Product(
                    productId: data.id.toString(),
                    count: 1,
                    name: data.name,
                    price: data.price.toDouble(),
                    imageUrl: data.imageUrl,
                  ),
                );
              }
              setState(() {
                isAddingToCart = false;
              });
            },
      child:  Text(
        "Savatga qo'shish",
        style: TextStyle(fontSize: 17.spMin,color: AppColors.white),
      ),
    );
  }
}
