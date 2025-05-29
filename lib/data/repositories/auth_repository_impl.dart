import 'package:result_dart/result_dart.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  AsyncResult<UserEntity> login(String username, String password) async {
    final result = await remoteDataSource.login(username, password);

    return result.fold(
      (userModel) => Success(userModel),
      (failure) => Failure(failure),
    );
  }
}
