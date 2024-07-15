import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<void> insert(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<void> delete(String key);
}

class HiveLocalStorage implements LocalStorage {
  @override
  Future<void> delete(String key) async {
    final box = await Hive.openBox('myBox');
    await box.delete(key);
  }

  @override
  Future<dynamic> get(String key) async {
    final box = await Hive.openBox('myBox');
    var data = await box.get(key);
    return data;
  }

  @override
  Future<void> insert(String key, dynamic value) async {
    final box = await Hive.openBox('myBox');
    await box.put(key, value);
  }
}
