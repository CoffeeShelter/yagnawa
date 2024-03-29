import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

String URL = 'http://211.59.155.146:5000';
// String URL = 'http://localhost:5000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Upload'),
        ),
        body: Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                uploadImage('비타민', File('assets/images/gmp.png'));
              },
              child: Text('Upload'),
            ),
          ),
        ),
      ),
    );
  }
}

uploadImage(String productName, File file) async {
  var request = http.MultipartRequest("POST", Uri.parse("$URL/image"));

  request.fields['productName'] = productName;
  request.headers['Origin'] = "http://localhost";

  var picture = http.MultipartFile.fromBytes(
    'files[]',
    (await rootBundle.load('assets/images/product03.jpg')).buffer.asUint8List(),
    filename: 'testimage.png',
  );

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);
  Map<String, dynamic> data = jsonDecode(result);
  print(data['result']['products']);
  print(data['result']['products'].length);
}
