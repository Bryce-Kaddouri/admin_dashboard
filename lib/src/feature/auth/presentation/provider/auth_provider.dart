import 'package:admin_dashboard/src/feature/auth/business/usecase/login_usecase.dart';
import 'package:flutter/material.dart';

import '../../business/param/login_params.dart';

class AuthProvider with ChangeNotifier {
  final AuthLoginUseCase authLoginUseCase;

  AuthProvider({required this.authLoginUseCase});

  bool _isLoggin = false;

  bool get isLogin => _isLoggin;

  void setIslogin(bool val) {
    _isLoggin = val;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<bool> login(String email, String password) async {
    /*LoginParams params = LoginParams(email: email, password: password);
    var response = authLoginUseCase.call(params);
    print(response);*/
    _isLoading = true;
    _loginErrorMessage = '';
    bool isSuccess = false;

    notifyListeners();
    final result = await authLoginUseCase
        .call(LoginParams(email: email, password: password));

    await result.fold((l) async {
      _loginErrorMessage = l.errorMessage;
      isSuccess = false;
    }, (r) async {
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
