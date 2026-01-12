import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthenticationState {

}

final class EmptyState extends AuthenticationState{
  EmptyState();
}

final class LoadingState extends AuthenticationState{
  LoadingState();
}

final class AuthenticatedState extends AuthenticationState{
  final User currentUser;

  AuthenticatedState(this.currentUser);
}

final class ErrorState extends AuthenticationState{
  final String errorMessage;

  ErrorState(this.errorMessage);
}