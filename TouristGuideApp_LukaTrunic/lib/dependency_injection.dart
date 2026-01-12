import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/data/client/firebase_auth_client.dart';
import 'package:tourist_guide_app/data/repository/user_repository_impl.dart';
import 'package:tourist_guide_app/domain/repository/user_repository.dart';
import 'package:tourist_guide_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:tourist_guide_app/presentation/auth/notifier/authentication_notifier.dart';
import 'package:tourist_guide_app/presentation/auth/notifier/state/authentication_state.dart';

final firebaseAuthClientProvider = Provider<FirebaseAuthClient>((_) => FirebaseAuthClient());

final userRepositoryProvider = Provider<UserRepository>(
        (ref) => UserRepositoryImpl(ref.watch(firebaseAuthClientProvider)),
);

final userSignInUseCaseProvider = Provider<UserSignInUseCase>(
    (ref) => UserSignInUseCase(ref.watch(userRepositoryProvider)),
);

final authenticationNotifierProvider = NotifierProvider<AuthenticationNotifier, AuthenticationState>(
    () => AuthenticationNotifier(),
);