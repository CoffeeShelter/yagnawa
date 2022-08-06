import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

late String productName;
late String componyName;

void getData() async {
  http.Response response = await http.get(
    Uri.encodeFull('http://127.0.0.1:5000/products/비타민'),
    headers: {"Accept": "application/json"},
  );

  List<dynamic> data = jsonDecode(response.body);

  ProductList productList = new ProductList.fromJson(data);
  print(productList.products?.first.productName);
}

class ProductList {
  final List<Product>? products;

  ProductList({
    this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products =
        parsedJson.map((i) => Product.fromJson(i)).toList();
    // products =

    return new ProductList(products: products);
  }
}

class Product {
  final String? productName;

  Product({
    this.productName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      productName: json['PRDLST_NM'],
    );
  }
}
