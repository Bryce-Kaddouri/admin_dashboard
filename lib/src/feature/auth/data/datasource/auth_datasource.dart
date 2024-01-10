import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final GoTrueClient authClient;
  AuthDataSource({required this.authClient});

  Future<Either<Exception, AuthResponse>> login(
      String email, String password) async {
    try {
      final response =
          await authClient.signInWithPassword(email: email, password: password);
      if (response.user != null &&
          response.user!.appMetadata['role'] == 'ADMIN') {
        return Right(response);
      } else {
        return Left(Exception('Invalid credentials'));
      }
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
