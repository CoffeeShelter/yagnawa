import 'package:flutter/material.dart';
import 'package:yagnawa/product_info_screen.dart';
import 'package:yagnawa/products.dart';
import 'appbar.dart';
import 'constants.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YagNaWa',
      home: Scaffold(
        appBar: yacnawaAppBar(),
        body: const MainScreen(),
        // body: const ProductInfoScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.green;
              } else {
                return yDefaultDarkGreen;
              }
            },
          ),
        ),
        child: const Text('Go'),
        onPressed: () {
          Future<ProductList> products = getProduct();

          products.then((val) {
            // print('val: ${val.products[0].functionality}');
            print('완료');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductInfoPage(),
              ),
            );
          }).catchError((error) {
            print('error: $error');
          });
        },
      ),
    );
  }
}
