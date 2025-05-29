import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:result_dart/result_dart.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/logger.dart';
import '../../models/user_model.dart';
import './auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final String _authEndpoint =
      'https://apimw.sistemagiv.com.br/TestMobile/auth';

  final String _mockPath = 'assets/mocks/auth_success_mock.json';

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  AsyncResult<UserModel> login(String username, String password) async {
    try {
      final response = await dio.post(
        _authEndpoint,
        data: {'user': username, 'password': password},
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['success'] == true && response.data['user'] != null) {
          return Success(UserModel.fromJson(response.data));
        } else {
          return _getMockAuthData();
        }
      } else {
        return _getMockAuthData();
      }
    } catch (_) {
      return _getMockAuthData();
    }
  }

  AsyncResult<UserModel> _getMockAuthData() async {
    log.w('Falha na API. Tentando carregar mock de autenticação');
    try {
      final String jsonString = await rootBundle.loadString(_mockPath);
      final jsonMap = jsonDecode(jsonString);
      final userModel = UserModel.fromJson(jsonMap);
      return Success(userModel);
    } catch (e, s) {
      log.e(
        'Falha ao carregar ou parsear o mock de autenticação',
        error: e,
        stackTrace: s,
      );
      return Failure(ServerException(stackTrace: s));
    }
  }
}
