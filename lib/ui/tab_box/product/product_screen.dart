import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/ui/router.dart';
import 'package:third_exam_n8/ui/tab_box/favorite/favorite_screen.dart';
import 'package:third_exam_n8/ui/tab_box/product/widgets/product_item.dart';
import 'package:third_exam_n8/ui/tab_box/widgets/shimmer_item.dart';
import 'package:third_exam_n8/utils/app_colors.dart';
import '../../../data/local/db/local_database.dart';
import '../../../data/models/product_model/product_model.dart';
import '../../../data/models/universal_data.dart';
import '../../../data/network/api_provider.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<ProductModel> productModels=[];

  List likes = [];


  bool loading = false;

  fetch()async{
    likes =  (await LocalDatabase.getAll()).map((e) => e as int).toList();
    setState(() {
    });
  }

  _getProductData() async {
    setState(() {
      loading = true;
    });
    List<UniversalData> result =
    await Future.wait([ApiProvider.getProductAll()]);

    if (result[0].error.isEmpty) {
      productModels = result.first.data as List<ProductModel>;
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
        title: Text("Hamma mahsulotlar",style: TextStyle(fontSize: 20.spMin,color: AppColors.white),),
        backgroundColor: AppColors.black,
        actions: [IconButton(onPressed: (){
          Navigator.pushNamed(context, RouteNames.favorite);
        }, icon: const Icon(Icons.favorite))],
      ),
      body: loading
          ? ShimmerItem()
          : ProductItem(productModels: productModels, likes: likes as List<int>)
    );
  }
}
