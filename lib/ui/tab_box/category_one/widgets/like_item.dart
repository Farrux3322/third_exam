import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_exam_n8/data/models/product_model/product_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../data/local/db/local_database.dart';

class LikeItem extends StatefulWidget {
   LikeItem({Key? key, required this.productModel,required this.isLike}) : super(key: key);

  final ProductModel productModel;
   bool isLike;
  @override
  State<LikeItem> createState() => _LikeItemState();
}

class _LikeItemState extends State<LikeItem> {

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Sevimlilarga qo'shildi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        setState(() {
          LocalDatabase.insert(widget.productModel);
          widget.isLike = !widget.isLike;
        });
      },
      child: Icon(
        !widget.isLike
            ? CupertinoIcons.heart
            : CupertinoIcons.heart_fill,
        color: widget.isLike
            ? Colors.red
            : Colors.black,
        size: 30,
      ),
    );
  }
}
