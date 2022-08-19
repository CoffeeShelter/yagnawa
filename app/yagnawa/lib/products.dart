import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

late String productName;
late String componyName;

void main() {
  getProduct();
}

Future<ProductList> getProduct({productName}) async {
  http.Response response = await http.get(
    Uri.encodeFull('http://localhost:5000/products/$productName'),
    headers: {
      "Accept": "application/json",
      "Origin": "http://localhost",
    },
  );

  List<dynamic> data = jsonDecode(response.body);
  // Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

  ProductList productList = ProductList.fromJson(data);
  // Product product = Product.fromJson(data);
  print(productList.products[0].functionality);

  // print(data.values);

  // return product;
  return productList;
}

class ProductList {
  List<Product> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products =
        parsedJson.map((i) => Product.fromJson(i)).toList();

    return ProductList(products: products);
  }
}

class Product {
  String productName; // 상품 명
  String componyName; // 회사 명
  List<dynamic> functionality; // 기능성
  String contents; // 함량 정보

  Product({
    required this.productName,
    required this.componyName,
    required this.functionality,
    required this.contents,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'] ??= 'null',
      componyName: json['componyName'] ??= 'null',
      functionality: json['functionally'] ??= 'null',
      contents: json['contents'] ??= 'null',
    );
  }
}
