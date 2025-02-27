import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final saveService = Provider<SaveItemService>((ref) {
  return SaveItemService();
});

class SaveItemService extends ChangeNotifier {
  Future<void> saveItem(String title, String value) async {
    var appDir = await getApplicationDocumentsDirectory();
    String filePath = "${appDir.path}/user_data.txt";
    File file = File(filePath);
    file.writeAsString('$title $value');
  }
}
