import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/usecase/usecase.dart';
import '../../../../core/data/exception/failure.dart';
import '../param/login_params.dart';
import '../repository/auth_repository.dart';

class AuthLoginUseCase implements UseCase<AuthResponse, LoginParams> {
  final AuthRepository authRepository;
  const AuthLoginUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) {
    return authRepository.login(params);
  }
}
