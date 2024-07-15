import '../../domain/entities/user_entity.dart';

class UserDTO extends UserEntity {
  UserDTO({
    required super.name,
    required super.balance,
    super.token,
  });

  @override
  UserEntity copyWith({required double balance}) {
    return UserDTO(balance: balance, name: name, token: token);
  }
}
