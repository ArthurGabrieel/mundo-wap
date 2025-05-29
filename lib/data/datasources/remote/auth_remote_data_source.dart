import 'package:result_dart/result_dart.dart';

import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Realiza login no aplicativo.
  /// Retorna [Result<UserModel, Exception>] contendo o usuário ou um erro.
  AsyncResult<UserModel> login(String username, String password);
}
