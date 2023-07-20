import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/local/db/local_database.dart';
import 'package:third_exam_n8/data/models/product_model/product_model.dart';
import 'package:third_exam_n8/ui/tab_box/favorite/widgets/favorite_item.dart';
import 'package:third_exam_n8/ui/tab_box/widgets/shimmer_item.dart';
import '../../../data/models/universal_data.dart';
import '../../../data/network/api_provider.dart';
import '../../../utils/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ProductModel> productModels = [];
  List<ProductModel> products = [];

  List likes = [];
  bool loading = false;

  fetch() async {
    likes = (await LocalDatabase.getAll()).map((e) => e as int).toList();
    setState(() {});
  }

  _getProductData() async {
    setState(() {
      loading = true;
    });
    List<UniversalData> result =
        await Future.wait([ApiProvider.getProductAll()]);

    if (result[0].error.isEmpty) {
      productModels = result.first.data as List<ProductModel>;
      products =
          productModels.where((element) => likes.contains(element.id)).toList();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetch();
    _getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          title: Text(
            "Sevimlilar",
            style: TextStyle(fontSize: 20.spMin, color: AppColors.white),
          ),
        ),
        body: loading
            ? ShimmerItem()
            : FavoriteItem(products: products)
    );
  }
}
