import 'package:admin_dashboard/src/core/data/exception/failure.dart';

import 'package:admin_dashboard/src/feature/auth/business/param/login_params.dart';

import 'package:dartz/dartz.dart';

import 'package:gotrue/src/types/auth_response.dart';

import '../../business/repository/auth_repository.dart';
import '../datasource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exception, AuthResponse>> login(LoginParams params) async {
    return await dataSource.login(params);
  }
}
