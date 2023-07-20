import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/models/category_model/cotegory_model.dart';
import 'package:third_exam_n8/data/models/universal_data.dart';
import 'package:third_exam_n8/data/network/api_provider.dart';
import 'package:third_exam_n8/ui/tab_box/category_all/widgets/category_item.dart';
import 'package:third_exam_n8/ui/tab_box/widgets/shimmer.dart';
import 'package:third_exam_n8/utils/app_colors.dart';

class CategoryAllScreen extends StatefulWidget {
  const CategoryAllScreen({Key? key}) : super(key: key);

  @override
  State<CategoryAllScreen> createState() => _CategoryAllScreenState();
}

class _CategoryAllScreenState extends State<CategoryAllScreen> {
  List<CategoryModel>? categoryModels;
  bool loading = false;
  _getCategoryData() async {
    setState(() {
      loading = true;
    });
    List<UniversalData> result =
        await Future.wait([ApiProvider.getAllProduct()]);

    if (result[0].error.isEmpty) {
      categoryModels = result.first.data as List<CategoryModel>;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text("Kategoriya",style: TextStyle(fontSize: 20.spMin,color: AppColors.white,fontWeight: FontWeight.w700),),
        centerTitle: true,

      ),
      body: loading
          ? MyShimmer()
          : CategoryItem(categoryModels: categoryModels!),
    );
  }
}
