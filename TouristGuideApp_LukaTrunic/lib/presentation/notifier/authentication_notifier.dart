import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:tourist_guide_app/presentation/notifier/state/authentication_state.dart';

import '../../domain/model/result.dart';

class AuthenticationNotifier extends Notifier<AuthenticationState>{
  late UserSignInUseCase _signInUseCase;

  @override
  build(){
    _signInUseCase = ref.watch(userSignInUseCaseProvider);
    return EmptyState();
  }

  void signIn(final String email, final String password) async {
    state = LoadingState();
    print("LOADING STATE");

    final result = await _signInUseCase(email, password);

    switch(result){
      case Ok<User>():
        state = AuthenticatedState(result.value);
        print("SUCCESS STATE");
      case Error():
        print("ERROR: ${result.error.toString()}");
        state = ErrorState(result.error.toString());
    }
  }
}