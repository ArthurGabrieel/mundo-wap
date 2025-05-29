import 'package:result_dart/result_dart.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  AsyncResult<UserEntity> call(String username, String password) async {
    return repository.login(username, password);
  }
}
