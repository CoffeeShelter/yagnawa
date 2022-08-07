import 'package:flutter/material.dart';

AppBar yacnawaAppBar() {
  return AppBar(
    leading: const IconButton(
      icon: Icon(Icons.menu),
      onPressed: null,
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
