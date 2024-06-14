import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      ArgumentError(e);
    }
  }

  @override
  Future<void> loginUser (
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      ArgumentError(e);
    }
  }
}
