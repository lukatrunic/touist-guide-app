import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide_app/domain/model/result.dart';
import 'package:tourist_guide_app/domain/repository/user_repository.dart';

class UserSignInUseCase {
  final UserRepository repository;

  UserSignInUseCase(this.repository);

  Future<Result<User>> call (final String email, final String password){
    return repository.signIn(email, password);
  }
}