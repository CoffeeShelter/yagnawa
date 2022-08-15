import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

late String productName;
late String componyName;

void main() {
  getProduct();
}

Future<Product> getProduct({productName}) async {
  http.Response response = await http.get(
    Uri.encodeFull('http://localhost:5000/products/$productName'),
    headers: {
      "Accept": "application/json",
      "Origin": "http://localhost",
    },
  );

  // List<dynamic> data = jsonDecode(response.body);
  Map<String, dynamic> data = jsonDecode(response.body);

  // ProductList productList = ProductList.fromJson(data);
  Product product = Product.fromJson(data);
  // print(productList.products[0].functionality);

  print(product.functionality);
  print(product.componyName);

  return product;
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
  String functionality; // 기능성
  String contents; // 함량 정보

  Product({
    required this.productName,
    required this.componyName,
    required this.functionality,
    required this.contents,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['PRDLST_NM'],
      componyName: json['BSSH_NM'],
      functionality: json['PRIMARY_FNCLTY'],
      contents: json['STDR_STND'],
    );
  }
}
