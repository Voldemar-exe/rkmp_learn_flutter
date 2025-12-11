import '../../../core/constants/auth_constants.dart';

class Validators {

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(AuthConstants.regexName).hasMatch(value)) {
      return 'Invalid name format';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(AuthConstants.regexEmail).hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(AuthConstants.regexPassword).hasMatch(value)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
