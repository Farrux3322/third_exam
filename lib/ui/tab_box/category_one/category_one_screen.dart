import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/local/db/local_database.dart';
import 'package:third_exam_n8/data/models/product_model/product_model.dart';
import 'package:third_exam_n8/ui/tab_box/category_one/widgets/category_detail_item.dart';
import 'package:third_exam_n8/ui/tab_box/widgets/shimmer_item.dart';
import '../../../data/models/universal_data.dart';
import '../../../data/network/api_provider.dart';
import '../../../utils/app_colors.dart';

class CategoryOneScreen extends StatefulWidget {
  const CategoryOneScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  final int id;
  final String name;

  @override
  State<CategoryOneScreen> createState() => _CategoryOneScreenState();
}

class _CategoryOneScreenState extends State<CategoryOneScreen> {
  List<ProductModel>? productModels;

  bool loading = false;

  List likes = [];

  _getProductData() async {
    setState(() {
      loading = true;
    });
    List<UniversalData> result =
        await Future.wait([ApiProvider.getProductById(widget.id)]);

    if (result[0].error.isEmpty) {
      productModels = result.first.data as List<ProductModel>;
    }
    setState(() {
      loading = false;
    });
  }

  fetch() async {
    likes = (await LocalDatabase.getAll()).map((e) => e as int).toList();
    setState(() {});
  }

  @override
  void initState() {
    _getProductData();
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(widget.name,style: TextStyle(fontSize: 20.spMin,color: AppColors.white),),
        centerTitle: true,
      ),
      body: loading
          ? ShimmerItem()
          : CategoryDetailItem(productModels: productModels!, likes:likes as List<int> ),
    );
  }
}
