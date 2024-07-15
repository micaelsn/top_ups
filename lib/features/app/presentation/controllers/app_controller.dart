import 'package:flutter/material.dart';

import '../../data/dtos/transition_dto.dart';
import '../../data/dtos/user_dto.dart';
import '../../domain/entities/user_entity.dart';

class AppController {
  final ValueNotifier<UserEntity> _user = ValueNotifier(UserDTO(
    name: 'User',
    balance: 0,
    transitions: [],
  ));

  ValueNotifier<UserEntity> get user => _user;
  void setUser(UserEntity newUser) => _user.value = newUser;

  String get userName => user.value.name.isNotEmpty ? user.value.name : 'User';
  bool get userVerified => user.value.token != null;
  double get transitionsAmountMonth => sumTrans();
  double get allTransitionsAmountMonth => sumTrans();
  double get userBalance => user.value.balance;

  double sumTrans() {
    double sum = 0;
    for (var trans in user.value.transitions) {
      sum += trans.value;
    }
    return sum;
  }

  void rechargeMobile(double recharge) {
    _createTransition('recharge', recharge);
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

  void _createTransition(String type, double value) {
    user.value.transitions.add(TransitionDTO(
      type: type,
      value: value,
      date: DateTime.now(),
    ));
  }
}
