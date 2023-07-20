import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:third_exam_n8/ui/tab_box/box/box_screen.dart';
import 'package:third_exam_n8/ui/tab_box/category_all/category_all_screen.dart';
import 'package:third_exam_n8/ui/tab_box/category_one/category_one_screen.dart';
import 'package:third_exam_n8/ui/tab_box/favorite/favorite_screen.dart';
import 'package:third_exam_n8/ui/tab_box/product/product_screen.dart';
import 'package:third_exam_n8/ui/tab_box/tab_box.dart';


class RouteNames {
  static const String initial = "/";
  static const String categoryAll = "/categoryAll";
  static const String favorite = "/favorite";
  static const String product = "/product";
  static const String box = "/box";
  static const String categoryOne = "/categoryOne";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
        return MaterialPageRoute(builder: (context) => TabBoxScreen());
      case RouteNames.categoryOne:
        return MaterialPageRoute(builder: (context) {
          Map<String,dynamic> map = settings.arguments as Map<String,dynamic>;
          return CategoryOneScreen(id: map['id'], name: map['name']);
        });
      case RouteNames.categoryAll:
        return MaterialPageRoute(builder: (context) =>  CategoryAllScreen());
      case RouteNames.favorite:
        return MaterialPageRoute(builder: (context) =>  FavoriteScreen());
      case RouteNames.product:
        return MaterialPageRoute(builder: (context) =>  ProductScreen());
      case RouteNames.box:
        return MaterialPageRoute(builder: (context) =>  BoxScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route mavjud emas"),
            ),
          ),
        );
    }
  }
}
