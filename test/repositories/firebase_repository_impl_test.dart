import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements AuthRepository {}

void main() {
  
  group('Firebase Repository Test', () {
// Primeiro teste TDD - tentativa com sucesso de criar cadastro
    test(
        'Verify the method call for creating a new registration with email and password',
        () async {
      final mockFirebaseAuth = MockFirebaseAuth();

      when(() => mockFirebaseAuth.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async {});

      await mockFirebaseAuth.registerUser(
          name: 'teste User', email: 'teste@gmail.com', password: '123456');

      verify(() => mockFirebaseAuth.registerUser(
          name: 'teste User',
          email: 'teste@gmail.com',
          password: '123456')).called(1);
    });

//Segundo teste TDD - tentativa com sucesso de logar após cadastro feito
    test('loginUser - success', () async {
      final mockFirebaseAuth = MockFirebaseAuth();

      when(() => mockFirebaseAuth.loginUser(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async {throw '';});

      await mockFirebaseAuth.loginUser(
          email: 'teste@gmail.com', password: '123456');

      verify(() => mockFirebaseAuth.loginUser(
          email: 'teste@gmail.com', password: '123456')).called(1);
    });
  });
}
