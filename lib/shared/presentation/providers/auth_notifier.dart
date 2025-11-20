import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/shared/data/models/user_model.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // FOR TEST
    return Authenticated(
      user: UserModel(
        id: 1,
        login: 'brendy',
        createdAt: DateTime.now(),
      ),
    );

    // return const Unauthenticated();
  }

  void updateState(AuthState state) {
    state = state;
  }
}
