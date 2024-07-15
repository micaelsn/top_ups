import 'package:flutter/material.dart';

abstract class _Navigator {
  Future<void> push(BuildContext context, String path);
  Future<void> pop(BuildContext context);
}

class ModuleNavigator implements _Navigator {
  @override
  Future<void> push(BuildContext context, String path, {dynamic arg}) async {
    Navigator.of(context).pushNamed(path, arguments: arg);
  }

  @override
  Future<void> pop(BuildContext context) async {
    Navigator.of(context).pop();
  }
}
