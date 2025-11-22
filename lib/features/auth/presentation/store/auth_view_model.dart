import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/shared/data/models/user.dart';
import 'package:rkmp_learn_flutter/shared/presentation/providers/auth_notifier.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/auth_state.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRepository _repository;
  late final TextEditingController loginController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  @override
  void build() {
    _repository = GetIt.I<AuthRepository>();

    loginController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    ref.onDispose(() {
      loginController.dispose();
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    });
  }

  Future<void> login({
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    try {
      _isSubmitting = true;
      final user = await _repository.login(
        loginController.text.trim(),
        passwordController.text.trim()
      );
      if (user != null) {
        onSuccess();
      } else {
        onError('Login failed');
      }
      _isSubmitting = false;
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> register({
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    try {
      final user = await _repository.register(
        emailController.text.trim(),
        passwordController.text.trim(),
        loginController.text.trim(),
      );
      if (user != null) {
        onSuccess();
      } else {
        onError('Registration failed');
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}
