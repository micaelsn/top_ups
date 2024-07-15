import 'transition_entity.dart';

abstract class UserEntity {
  final String name;
  final double balance;
  final String? token;
  final List<TransitionEntity> transitions;

  UserEntity({
    required this.name,
    required this.balance,
    required this.transitions,
    this.token,
  });

  UserEntity copyWith({required double balance});
}
