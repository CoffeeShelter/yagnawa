import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar yacnawaAppBar() {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        Get.back();
      },
    ),
    title: const Text("약나와"),
    centerTitle: true,
    actions: const [
      IconButton(icon: Icon(Icons.camera), onPressed: null),
      IconButton(icon: Icon(Icons.search), onPressed: null),
    ],
    backgroundColor: Colors.green,
  );
}
