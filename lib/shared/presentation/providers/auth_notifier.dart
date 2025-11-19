import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/auth_state.dart';


part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const Unauthenticated();
  }

  void updateState(AuthState state) {
    state = state;
  }
}
