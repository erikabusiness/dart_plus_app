import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/error/firebase_auth_error_handler.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User registered: ${userCredential.user!.uid}");

      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
      });

      print("User data added to Firestore");
    } on FirebaseAuthException catch (e) {
      FirebaseAuthErrorHandler.handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.message}");
      throw Exception('Erro ao adicionar dados do usuário no Firestore: ${e.message}');
    } catch (e) {
      print("Unknown error: $e");
      throw Exception('Erro desconhecido ao registrar usuário.');
    }
  }

  @override
  Future<Map<String, String>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User logged in: ${userCredential.user!.uid}");

      DocumentSnapshot userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          String name = userData['name'];
          String userEmail = userData['email'];
          print("User data retrieved from Firestore: $userData");
          return {'name': name, 'email': userEmail};
        } else {
          throw Exception('Dados do usuário não encontrados no Firestore.');
        }
      } else {
        throw Exception('Documento do usuário não encontrado no Firestore.');
      }
    } on FirebaseAuthException catch (e) {
      FirebaseAuthErrorHandler.handleFirebaseAuthException(e);
      rethrow;
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.message}");
      throw Exception('Erro ao buscar dados do usuário no Firestore: ${e.message}');
    } catch (e) {
      print("Unknown error: $e");
      throw Exception('Erro desconhecido ao fazer login.');
    }
  }
}
