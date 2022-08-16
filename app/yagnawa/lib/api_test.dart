import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Upload'),
        ),
        body: Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                uploadImage('image', File('assets/images/gmp.png'));
              },
              child: Text('Upload'),
            ),
          ),
        ),
      ),
    );
  }
}

uploadImage(String title, File file) async {
  var request =
      http.MultipartRequest("POST", Uri.parse("http://localhost:5000/image"));

  // request.fields['title'] = "dummyImage";
  request.headers['Origin'] = "http://localhost";

  var picture = http.MultipartFile.fromBytes(
    'files[]',
    (await rootBundle.load('assets/images/product04.jpg')).buffer.asUint8List(),
    filename: 'testimage.png',
  );

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);
  Map<String, dynamic> data = jsonDecode(result);
  print(data['mark']);
}
