import 'package:result_dart/result_dart.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  AsyncResult<UserEntity> login(String username, String password);
}
