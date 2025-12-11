import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/auth_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: AuthForm(
          authType: AuthType.login,
          onSuccess: () {
            context.go('/home');
          },
        ),
      ),
    );
  }
}
