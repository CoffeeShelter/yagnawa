import 'package:flutter/material.dart';
import 'package:yagnawa/product_info_screen.dart';
import 'appbar.dart';

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
        child: const Text('Go'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductInfoPage()),
          );
        },
      ),
    );
  }
}
