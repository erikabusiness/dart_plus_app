import 'package:dart_plus_app/domain/error/custom_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorHandler {
  static final Map<String, String> _errorMessages = {
    'invalid-email': 'O email fornecido é inválido.',
    'wrong-password': 'A senha é inválida para o email fornecido.',
    'user-disabled': 'O usuário correspondente ao email fornecido foi desativado.',
    'user-not-found': 'Não há nenhum usuário correspondente ao email fornecido.',
    'email-already-in-use': 'O email já está em uso. Tente outro email.',
    'operation-not-allowed': 'Contas de email/senha não estão habilitadas.',
    'weak-password': 'A senha fornecida é muito fraca.',
    'too-many-requests': 'Muitas tentativas de login. Tente novamente mais tarde.',
    'requires-recent-login': 'A operação requer login recente. Faça login novamente.',
    'account-exists-with-different-credential': 'Já existe uma conta com credenciais diferentes.',
    'invalid-credential': 'Email ou senha inválidas.',
    'invalid-verification-code': 'O código de verificação fornecido é inválido.',
    'invalid-verification-id': 'O ID de verificação fornecido é inválido.',
  };

  static void handleFirebaseAuthException(FirebaseAuthException e) {
    final errorMessage = _errorMessages[e.code] ?? 'Erro desconhecido';
    throw CustomException(errorMessage);
  }

  static void handleGenericException(Object e) {
    throw CustomException('Erro: $e');
  }
}
