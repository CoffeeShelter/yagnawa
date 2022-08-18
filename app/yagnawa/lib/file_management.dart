import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage {
  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/req.json');
  }

  Future<File> writeRequest(Map<String, dynamic> jsonData) async {
    final file = await _localFile;

    String jsonString = jsonEncode(jsonData);

    return file.writeAsString('$jsonString');
  }
}
