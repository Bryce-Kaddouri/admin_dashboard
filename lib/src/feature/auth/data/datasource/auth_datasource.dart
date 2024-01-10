import 'package:admin_dashboard/src/feature/auth/business/param/login_params.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final _auth = Supabase.instance.client.auth;

  Future<Either<Exception, AuthResponse>> login(LoginParams params) async {
    try {
      final response = await _auth.signInWithPassword(
          email: params.email, password: params.password);
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
