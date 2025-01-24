import 'package:count1/model/counter_model.dart';
import 'package:riverpod/riverpod.dart';

class ItemProvider extends Notifier<Future<List<CounterModel>>> {
  @override
  build() {
    return Future.value([]);
  }

  Future<List<CounterModel>> getItems() async {
    return Future.value([]);
  }
}
