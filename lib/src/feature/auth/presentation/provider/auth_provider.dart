import 'package:admin_dashboard/src/feature/auth/business/usecase/login_usecase.dart';
import 'package:flutter/material.dart';

import '../../business/param/login_params.dart';

class AuthProvider with ChangeNotifier {
  final AuthLoginUseCase authLoginUseCase;
  AuthProvider({required this.authLoginUseCase});

  Future<void> login(String email, String password) async {
    await authLoginUseCase(LoginParams(email: email, password: password));
  }
}
