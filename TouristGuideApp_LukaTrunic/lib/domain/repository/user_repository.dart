import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide_app/domain/model/result.dart';

abstract interface class UserRepository{
  Future<Result<User>> signIn(final String email, final String password);
  Future<Result<User>> signUp(String email, String password);
  Future<void> signOut();
}