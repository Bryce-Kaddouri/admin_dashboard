import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  // global key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controller for the email field
  final TextEditingController _emailController = TextEditingController();

  // controller for the password field
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Sign In'),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthProvider>().login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
