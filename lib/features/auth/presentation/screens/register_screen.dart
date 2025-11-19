import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/auth/presentation/widgets/auth_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: AuthForm(
          authType: AuthType.register,
          onSuccess: () {
            context.go('/profile');
          },
        ),
      ),
    );
  }
}
