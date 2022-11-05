import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// String URL = 'http://10.0.2.2:5000';
String URL = 'http://211.59.155.207:5000';
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

  // rootBundle.load('assets/product01.png').then(
  //   (data) {
  //     bytes = data.buffer.asUint8List();
  //   },
  // );

  var picture = http.MultipartFile.fromBytes(
    'files[]',
    bytes,
    filename: 'testimage.png',
  );

  request.files.add(picture);

  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var result = String.fromCharCodes(responseData);

  Map<String, dynamic> data = jsonDecode(result);

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

Future<Map<String, dynamic>> uploadImage(
    String productName, Uint8List filePath, List boundingBoxVertex) async {
  var request = http.MultipartRequest("POST", Uri.parse("$URL/image"));

  request.fields['productName'] = productName;
  request.fields['startDx'] = boundingBoxVertex[0].toString();
  request.fields['startDy'] = boundingBoxVertex[1].toString();
  request.fields['endDx'] = boundingBoxVertex[2].toString();
  request.fields['endDy'] = boundingBoxVertex[3].toString();

  request.headers['Origin'] = "http://localhost";

  var picture = http.MultipartFile.fromBytes(
    'files[]',
    // (await rootBundle.load('assets/images/product03.jpg')).buffer.asUint8List(),
    // await File(filePath).readAsBytes(),
    filePath,
    filename: 'testimage.png',
  );

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);
  Map<String, dynamic> data = jsonDecode(result);

  return data;
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
  List<dynamic> contents; // 함량 정보
  List<dynamic> extra; // 기타 정보
  List<dynamic> marks; // 인증마크
  String image; // 이미지 주소
  ProductList recommendedProducts; // 추천된 제품들

  Product({
    required this.productCode,
    required this.productName,
    required this.componyName,
    required this.functionality,
    required this.contents,
    required this.extra,
    required this.marks,
    required this.image,
    required this.recommendedProducts,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productCode: json['productCode'] ??= 'null',
      productName: json['productName'] ??= 'null',
      componyName: json['componyName'] ??= 'null',
      functionality: json['functionally'] ??= [],
      contents: json['contents'] ??= [],
      extra: json['extra'] ??= [],
      marks: json['mark'] ??= [],
      image: json['image'] ??= '',
      recommendedProducts: ProductList.fromJson(json['recommended_products']),
    );
  }
}
