abstract class UserEntity {
  final String name;
  final double balance;
  final String? token;

  UserEntity({
    required this.name,
    required this.balance,
    this.token,
  });

  UserEntity copyWith({required double balance});
}
