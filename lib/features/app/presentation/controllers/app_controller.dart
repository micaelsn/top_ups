import 'package:flutter/material.dart';

import '../../data/dtos/transition_dto.dart';
import '../../data/dtos/user_dto.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_transitions_usecase.dart';
import '../../domain/usecases/save_transitions_usecase.dart';

class AppController {
  final GetTransitionsUsecase getTransitionsUsecase;
  final SaveTransitionsUsecase saveTransitionsUsecase;

  final ValueNotifier<UserEntity> _user = ValueNotifier(UserDTO(
    name: 'User',
    balance: 0,
    transitions: [],
  ));

  AppController({
    required this.getTransitionsUsecase,
    required this.saveTransitionsUsecase,
  });

  ValueNotifier<UserEntity> get user => _user;
  void setUser(UserEntity newUser) => _user.value = newUser;

  String get userName => user.value.name.isNotEmpty ? user.value.name : 'User';
  bool get userVerified => user.value.token != null;
  double transitionsAmountMonth(String id) => sumTransById(id);
  double get allTransitionsAmountMonth => sumTransMonth();
  double get userBalance => user.value.balance;

  void init(UserEntity newUser) async {
    final result = await getTransitionsUsecase();
    result.fold(
      (_) => _,
      (r) => newUser.transitions.addAll(r),
    );

    setUser(newUser);
  }

  double sumTransById(String id) {
    double sum = 0;
    for (var trans in user.value.transitions) {
      if (trans.idBeneficiary == id) {
        sum += trans.value;
      }
    }
    return sum;
  }

  double sumTransMonth() {
    double sum = 0;
    for (var trans in user.value.transitions) {
      sum += trans.value;
    }
    return sum;
  }

  void rechargeMobile(double recharge, String id) {
    _createTransition('recharge', recharge, id);
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

  void _createTransition(String type, double value, String id) {
    user.value.transitions.add(TransitionDTO(
      type: type,
      value: value,
      date: DateTime.now(),
      idBeneficiary: id,
    ));
    saveTransitionsUsecase(transitions: user.value.transitions);
  }
}
