import 'package:get_it/get_it.dart';

class Injection {
  static final Injection _instance = Injection._internal();

  factory Injection() {
    return _instance;
  }

  Injection._internal();

  final GetIt _getIt = GetIt.instance;

  void registerSingleton<T extends Object>(T instance) {
    if (_getIt.isRegistered<T>(instance: instance)) {
      _getIt.unregister<T>(instance: instance);
    }
    _getIt.registerSingleton<T>(instance);
  }

  void registerFactory<T extends Object>(T Function() factoryFunc) {
    if (_getIt.isRegistered<T>(instance: factoryFunc)) {
      _getIt.unregister<T>(instance: factoryFunc);
    }
    _getIt.registerFactory<T>(factoryFunc);
  }

  T get<T extends Object>() {
    return _getIt<T>();
  }
}
