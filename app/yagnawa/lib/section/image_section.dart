import 'package:flutter/material.dart';
import '../products.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    Key? key,
    required this.size,
    required this.product,
  }) : super(key: key);

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
    var noImage = Container(
      height: size.height * 0.4,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/No-Image-Found.png",
          ),
        ),
      ),
    );

    var netImage = Container(
      height: size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(product.image),
        ),
      ),
    );

    if (product.image != '') {
      return netImage;
    }

    return noImage;
  }
}
