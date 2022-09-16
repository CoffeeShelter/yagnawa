import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

String URL = 'https://10.0.2.2:5000';
// String URL = 'http://211.59.155.207:5000';
// String URL = 'http://localhost:5000';

// 단일 상품 정보
Future<Product> getProduct({productCode}) async {
  http.Response response = await http.get(
    Uri.parse('$URL/product/$productCode'),
    headers: {
      "Accept": "*/*",
      "Origin": "http://localhost",
      "Connection": "Keep-Alive",
    },
  );

  Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

  Product product = Product.fromJson(data);

  return product;
}

// 단일 상품 정보 (사진)
Future<Map<String, dynamic>> getProductWithImage(
    {productName, required File image}) async {
  var request = http.MultipartRequest("POST", Uri.parse("$URL/image"));

  request.fields['productName'] = productName;

  request.headers['Accept'] = "*/*";
  request.headers['Origin'] = "http://localhost";

  Uint8List bytes = image.readAsBytesSync();

  rootBundle.load('assets/product01.png').then(
    (data) {
      bytes = data.buffer.asUint8List();
    },
  );

  var picture = http.MultipartFile.fromBytes(
    'files[]',
    // (await rootBundle.load(image.path)).buffer.asUint8List(),
    bytes,
    filename: 'testimage.png',
  );

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);
  Map<String, dynamic> data = jsonDecode(result);
  print(data['mark']);

  Product product = Product.fromJson(data);

  return data;
}

// 상품 목록
Future<ProductList?> getProducts({productName}) async {
  http.Response response = await http.get(
    Uri.parse('$URL/products/$productName'),
    headers: {
      "Accept": "*/*",
      "Origin": "http://localhost",
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    },
  );

  List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

  ProductList productList = ProductList.fromJson(data);

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
