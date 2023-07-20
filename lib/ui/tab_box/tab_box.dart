import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:third_exam_n8/ui/tab_box/box/box_screen.dart';
import 'package:third_exam_n8/ui/tab_box/category_all/category_all_screen.dart';
import 'package:third_exam_n8/ui/tab_box/product/product_screen.dart';


class TabBoxScreen extends StatefulWidget {
  TabBoxScreen({Key? key}) : super(key: key);

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();

}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int _currentIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(CategoryAllScreen());
    screens.add(ProductScreen());
    screens.add(BoxScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white60,
          selectedItemColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.category_outlined, size: 30), label: "Kategoriya"),
            BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits_outlined, size: 30), label: "Mahsulotlar"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart, size: 30), label: "Savat"),
          ],
        ),
      ),
    );
  }
}