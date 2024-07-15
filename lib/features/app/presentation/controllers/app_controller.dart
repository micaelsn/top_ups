import 'package:flutter/material.dart';

import '../../data/dtos/user_dto.dart';
import '../../domain/entities/user_entity.dart';

class AppController {
  final ValueNotifier<UserEntity> _user =
      ValueNotifier(UserDTO(name: 'Micael', balance: 4000));

  ValueNotifier<UserEntity> get user => _user;
  String get userName => user.value.name.isNotEmpty ? user.value.name : 'User';
  bool get userVerified => user.value.token != null;

  void rechargeMobile(double recharge) {
    _transitionRate();
    _recharge(recharge);
  }

  void _transitionRate() {
    var newBalance = user.value.balance - 1.0;
    user.value = user.value.copyWith(balance: newBalance);
  }

  void _recharge(double recharge) {
    final newBalance = user.value.balance - recharge;
    user.value = user.value.copyWith(balance: newBalance);
  }
}
