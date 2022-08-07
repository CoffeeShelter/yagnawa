import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

late String productName;
late String componyName;

void main() {
  getData();
}

Future<ProductList> getData() async {
  http.Response response = await http.get(
    Uri.encodeFull('http://127.0.0.1:5000/products/비타민'),
    headers: {"Accept": "application/json"},
  );

  List<dynamic> data = jsonDecode(response.body);

  ProductList productList = new ProductList.fromJson(data);
  // print(productList.products[0].functionality);
  return productList;
}

class ProductList {
  List<Product> products;

  ProductList({
    products,
  }) : this.products = products;

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products =
        parsedJson.map((i) => Product.fromJson(i)).toList();

    return new ProductList(products: products);
  }
}

class Product {
  String productName; // 상품 명
  String componyName; // 회사 명
  String functionality; // 기능성
  String contents; // 함량 정보

  Product({
    productName,
    componyName,
    functionality,
    contents,
  })  : this.productName = productName,
        this.componyName = componyName,
        this.functionality = functionality,
        this.contents = contents;

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      productName: json['PRDLST_NM'],
      componyName: json['BSSH_NM'],
      functionality: json['PRIMARY_FNCLTY'],
      contents: json['STDR_STND'],
    );
  }
}
