import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:tourist_guide_app/presentation/auth/notifier/state/authentication_state.dart';

import '../../../domain/model/result.dart';
import '../../../domain/usecase/user_sign_up_use_case.dart';

class AuthenticationNotifier extends Notifier<AuthenticationState> {
  late UserSignInUseCase _signInUseCase;
  late UserSignUpUseCase _signUpUseCase;

  @override
  build() {
    _signInUseCase = ref.watch(userSignInUseCaseProvider);
    _signUpUseCase = ref.watch(userSignUpUseCaseProvider);
    return EmptyState();
  }

  void signIn(final String email, final String password) async {
    state = LoadingState();
    print("LOADING STATE");

    await Future.delayed(const Duration(seconds: 2));

    final result = await _signInUseCase(email, password);

    switch (result) {
      case Ok<User>():
        state = AuthenticatedState(result.value);
        print("SUCCESS STATE");
      case Error():
        print("ERROR: ${result.error.toString()}");
        state = ErrorState(result.error.toString());
    }
  }

  void signUp(final String email, final String password) async {
    state = LoadingState();

    final result = await _signUpUseCase(email, password);

    switch (result) {
      case Ok<User>():
        state = AuthenticatedState(result.value);
      case Error():
        state = ErrorState(result.error.toString());
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    state = EmptyState();
  }

  void checkAuthStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      state = AuthenticatedState(user);
    } else {
      state = EmptyState();
    }
  }
}
