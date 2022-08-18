import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/product_info_screen.dart';
import 'package:yagnawa/products_list_screen.dart';
// import 'appbar.dart';
import 'main_screen.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YagNaWa',
      getPages: [
        GetPage(
          name: '/product',
          // page: () => const ProductListScreen(),
          page: () => const ProductInfoPage(),
        ),
      ],
      // home: MainScreen(),
      home: ProductListScreen(),
    );
  }
}
