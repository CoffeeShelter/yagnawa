import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

late String productName;
late String componyName;

void main() {
  getProducts();
}

// 단일 상품 정보
Future<Product> getProduct({productCode}) async {
  http.Response response = await http.get(
    Uri.encodeFull('http://localhost:5000/product/$productCode'),
    headers: {
      "Accept": "application/json",
      "Origin": "http://localhost",
    },
  );

  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

  Product product = Product.fromJson(data);

  return product;
}

// 상품 목록
Future<ProductList> getProducts({productName}) async {
  http.Response response = await http.get(
    Uri.encodeFull('http://localhost:5000/products/$productName'),
    headers: {
      "Accept": "application/json",
      "Origin": "http://localhost",
    },
  );

  List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
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
  String productCode; // 상품 코드
  String productName; // 상품 명
  String componyName; // 회사 명
  List<dynamic> functionality; // 기능성
  String contents; // 함량 정보

  Product({
    required this.productCode,
    required this.productName,
    required this.componyName,
    required this.functionality,
    required this.contents,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productCode: json['productCode'] ??= 'null',
      productName: json['productName'] ??= 'null',
      componyName: json['componyName'] ??= 'null',
      functionality: json['functionally'] ??= [],
      contents: json['contents'] ??= 'null',
    );
  }
}
