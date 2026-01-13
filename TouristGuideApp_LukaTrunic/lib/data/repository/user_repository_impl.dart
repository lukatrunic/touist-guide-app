import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide_app/data/client/firebase_auth_client.dart';
import 'package:tourist_guide_app/domain/model/result.dart';
import 'package:tourist_guide_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthClient firebaseClient;

  UserRepositoryImpl(this.firebaseClient);

  @override
  Future<Result<User>> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseClient.signIn(email, password);
      return Result.ok(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return Result.error(Exception("Invalid email or password"));
      }
      return Result.error(Exception("Authentication internal error"));
    } catch (e) {
      return Result.error(Exception("There was an error."));
    }
  }

  @override
  Future<Result<User>> signUp(String email, String password) async {
    try {
      final credentials = await firebaseClient.signUp(email, password);

      return Result.ok(credentials.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Result.error(Exception("Email already in use"));
      }
      if (e.code == 'weak-password') {
        return Result.error(Exception("Password is too weak"));
      }
      return Result.error(Exception("Authentication error"));
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseClient.signOut();
  }

}
