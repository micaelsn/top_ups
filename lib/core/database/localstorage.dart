import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<void> insert(String key, Map value);
  Future<String> get(String key);
  Future<void> delete(String key);
}

class HiveLocalStorage implements LocalStorage {
  @override
  Future<void> delete(String key) async {
    final box = await Hive.openBox('myBox');
    await box.delete(key);
  }

  @override
  Future<String> get(String key) async {
    final box = await Hive.openBox('myBox');
    var name = await box.get(key);
    return name.toString();
  }

  @override
  Future<void> insert(String key, Map value) async {
    final box = await Hive.openBox('myBox');
    await box.put(key, value);
  }
}
