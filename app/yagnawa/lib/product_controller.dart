import 'package:get/get.dart';

import 'products.dart';

class ProductController extends GetxController {
  late Product product;

  void setProduct(Product product) {
    product = product;
    update();
  }
}
