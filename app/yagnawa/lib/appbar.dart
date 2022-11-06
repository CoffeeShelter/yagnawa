import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yagnawa/constants.dart';

AppBar yacnawaAppBar() {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded, color: yDefaultDarkGreen),
      onPressed: () {
        Get.back();
      },
    ),
    title: const Text(
      '약나와',
      style: TextStyle(
        color: yDefaultDarkGreen,
        fontSize: 30,
        fontFamily: 'Jua',
        letterSpacing: 2.0,
      ),
    ),
    centerTitle: true,
    actions: const [
      // IconButton(icon: Icon(Icons.camera), onPressed: null),
      // IconButton(icon: Icon(Icons.search), onPressed: null),
    ],
    backgroundColor: yDefaultGrey,
  );
}
