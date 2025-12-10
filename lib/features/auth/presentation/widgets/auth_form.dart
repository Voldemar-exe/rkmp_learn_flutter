import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/auth/presentation/store/auth_view_model.dart';
import 'package:rkmp_learn_flutter/shared/presentation/widgets/custom_text_field.dart';
import 'package:rkmp_learn_flutter/core/utils/validators.dart';

enum AuthType {
  login('Добро пожаловать!'),
  register('Создать аккаунт');

  final String desc;

  const AuthType(this.desc);
}

class AuthForm extends ConsumerWidget {
  final AuthType authType;
  final void Function() onSuccess;

  const AuthForm({super.key, required this.authType, required this.onSuccess});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    final isRegisterForm = authType == AuthType.register;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                authType.desc,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Логин',
                hint: 'Введите логин',
                controller: authViewModel.loginController,
                prefixIcon: const Icon(Icons.person_outline),
              ),

              if (isRegisterForm) ...[
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Почта',
                  hint: 'Введите почту',
                  keyboardType: TextInputType.emailAddress,
                  controller: authViewModel.emailController,
                  validator: Validators.validateEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ],

              const SizedBox(height: 16),

              CustomTextField(
                label: 'Пароль',
                hint: 'Введите пароль',
                obscureText: true,
                controller: authViewModel.passwordController,
                validator: Validators.validatePassword,
                prefixIcon: const Icon(Icons.lock_outline),
              ),

              if (isRegisterForm) ...[
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Подтверждение пароля',
                  hint: 'Введите пароль ещё раз',
                  obscureText: true,
                  controller: authViewModel.confirmPasswordController,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    authViewModel.passwordController.text,
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ],

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (isRegisterForm) {
                      authViewModel.register(
                        onError: (error) => ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error))),
                        onSuccess: onSuccess,
                      );
                    } else {
                      authViewModel.login(
                        onError: (error) => ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error))),
                        onSuccess: onSuccess,
                      );
                    }
                  },
                  child: authViewModel.isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(isRegisterForm ? 'Зарегистрироваться' : 'Войти'),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isRegisterForm) {
                    print('login');
                    context.go('/login');
                  } else {
                    print('register');
                    context.go('/register');
                  }
                },
                child: Text(!isRegisterForm ? 'Зарегистрироваться' : 'Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
