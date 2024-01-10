import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/exception/failure.dart';
import '../param/login_params.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, AuthResponse>> login(LoginParams params);
/*
  Future<Either<Failure, String>> logout();
*/
/*bool isLoggedIn();
  String getUserToken();*/
}
