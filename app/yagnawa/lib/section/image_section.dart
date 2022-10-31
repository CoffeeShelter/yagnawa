import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "assets/images/product04.jpg",
          ),
        ),
      ),
    );
  }
}
