import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'view/product_info_screen.dart';
import 'view/products_list_screen.dart';
import 'main_screen.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return GetMaterialApp(
      title: 'YagNaWa',
      getPages: [
        /*
        GetPage(
          name: '/product',
          // page: () => const ProductListScreen(),
          page: () => const ProductInfoPage(),
        ),
        */
        GetPage(
          name: '/products',
          page: () => const ProductListPage(),
        ),
      ],
      home: MainScreen(),
      // home: ProductListScreen(),
    );
  }
}
