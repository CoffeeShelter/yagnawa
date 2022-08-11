import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/product_info_screen.dart';
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
          page: () => const ProductInfoPage(),
        ),
      ],
      home: Scaffold(
        body: MainScreen(),
        // body: const ProductInfoScreen(),
      ),
    );
  }
}
