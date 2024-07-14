import '../../data/dtos/user_dto.dart';

class AppController {
  final _user = UserDTO(name: 'Micael', balance: 4000);

  String get userName => _user.name.isNotEmpty ? _user.name : 'User';
  String get userBalance => _user.balance.toString();
}
