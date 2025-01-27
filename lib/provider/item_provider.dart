import 'dart:io';
import 'package:count1/model/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class ItemNotifier extends Notifier<Future<List<CounterModel>>> {
  @override
  build() {
    return Future.value([]);
  }

  Future<List<CounterModel>> getItems() async {
    var appDir = await getApplicationDocumentsDirectory();
    String filePath = "${appDir.path}/user_data.txt";
    debugPrint(filePath);
    try {
      File file = File(filePath);
      if (await file.exists()) {
        List<String> fileContents = await file.readAsLines();
        List<CounterModel> counterList = fileContents
            .map((item) => CounterModel(
                title: item[0].split(' ')[0], value: item[0].split(' ')[1]))
            .toList();
        return Future.value(counterList);
      }
    } catch (e) {
      debugPrint('$e');
    }
    return Future.value([]);
  }

  dynamic setItems(String title, String value) async {
    print("Title ${title}");
    print(value);
    var appDir = await getApplicationDocumentsDirectory();
    String filePath = "${appDir.path}/user_data.txt";
    File file = File(filePath);
    file.writeAsString("$title $value\n");
  }
}

final itemNotifierProvider =
    NotifierProvider<ItemNotifier, Future<List<CounterModel>>>(() {
  return ItemNotifier();
});
