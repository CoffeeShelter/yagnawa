import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/main_screen.dart';
import 'package:yagnawa/products.dart';
import '../constants.dart';
import '../products.dart';

class ProductSelectPage extends StatelessWidget {
  Map<String, dynamic> data;

  ProductSelectPage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? productName = Get.parameters['productName'];

    productName ??= '';

    return MaterialApp(
      title: 'YagNaWa',
      home: Scaffold(
        body: ProductSelectScreen(
          productName: data['result']['detected_name'],
          data: data,
        ),
      ),
    );
  }
}

class ProductSelectScreen extends StatefulWidget {
  ProductSelectScreen({
    Key? key,
    required this.productName,
    required this.data,
  }) : super(key: key);

  final List<Color> colors = [yDefaultDarkGreen, yDefaultGreen];
  final String productName;
  Map<String, dynamic> data;

  @override
  State<ProductSelectScreen> createState() => _ProductSelectScreenState();
}

class _ProductSelectScreenState extends State<ProductSelectScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductList products =
        ProductList.fromJson(widget.data['result']['products']);

    return Column(
      children: <Widget>[
        TopArea(size: size),
        Container(
          width: size.width * 0.67,
          child: TextField(
            decoration: InputDecoration(
              hintText: widget.data['result']['detected_name'],
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search_rounded),
                color: yDefaultGreen,
                iconSize: 22.0,
                onPressed: () {},
              ),
            ),
          ),
        ),
        Expanded(
          child: products.products.isNotEmpty
              ? Container(
                  color: yDefaultGrey,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemCard(
                        size: size,
                        colors: widget.colors,
                        index: index,
                        product: products.products[index],
                      );
                    },
                  ),
                )
              : const Text('검색 결과가 없습니다.\n상품 명을 확인해주십시오.'),
        ),
      ],
    );
  }
}

// class ProductSelectScreen extends StatelessWidget {
//   ProductSelectScreen({
//     Key? key,
//     required this.productName,
//     required this.data,
//   }) : super(key: key);

//   final List<Color> colors = [yDefaultDarkGreen, yDefaultGreen];
//   final String productName;
//   Map<String, dynamic> data;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     ProductList products = ProductList.fromJson(data['result']['products']);

//     return Column(
//       children: <Widget>[
//         TopArea(size: size),
//         Container(
//           width: size.width * 0.67,
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: data['result']['detected_name'],
//               hintStyle: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               enabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.search_rounded),
//                 color: yDefaultGreen,
//                 iconSize: 22.0,
//                 onPressed: () {},
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: products.products.isNotEmpty
//               ? Container(
//                   color: yDefaultGrey,
//                   child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: products.products.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ItemCard(
//                         size: size,
//                         colors: colors,
//                         index: index,
//                         product: products.products[index],
//                       );
//                     },
//                   ),
//                 )
//               : const Text('검색 결과가 없습니다.\n상품 명을 확인해주십시오.'),
//         ),
//       ],
//     );
//   }
// }

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.size,
    required this.colors,
    required this.index,
    required this.product,
  }) : super(key: key);

  final Size size;
  final List<Color> colors;
  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 6.0,
          bottom: 6.0,
        ),
        color: Colors.white,
        height: size.height * 0.17,
        child: Stack(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              color: colors[index % 2],
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: size.width * 0.2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/No-Image-Found.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontSize: yDefaultBigFontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                right: 5.0,
                              ),
                              child: const Icon(Icons.business),
                            ),
                            Text(
                              product.componyName,
                              style: const TextStyle(
                                fontSize: yDefaultBigFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed('/product?productCode=${product.productCode}');
      },
    );
  }
}

class TopArea extends StatelessWidget {
  const TopArea({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
        bottom: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackButton(size: size),
          const LogoText(),
          SizedBox(
            width: size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(icon: const Icon(Icons.camera), onPressed: () {}),
                // IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LogoText extends StatelessWidget {
  const LogoText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Text(
    //   '약나와',
    //   style: TextStyle(
    //     color: yDefaultDarkGreen,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 40,
    //     fontFamily: 'Jua',
    //   ),
    // );
    return TextButton(
      child: const Text(
        '약나와',
        style: TextStyle(
          color: yDefaultDarkGreen,
          fontWeight: FontWeight.bold,
          fontSize: 40,
          fontFamily: 'Jua',
        ),
      ),
      onPressed: () => Get.to(MainScreen()),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: size.width * 0.3,
      child: IconButton(
        visualDensity: VisualDensity.compact,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
