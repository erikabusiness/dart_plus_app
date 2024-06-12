import 'package:dart_plus_app/presentation/view/register_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Teste da página de cadastro de usuário
  final name = faker.person.name();
  final email = faker.internet.email();
  final password = faker.internet.password();

  Widget makeSut() => const MaterialApp(home: RegisterPage());

// Teste de Validação de componentes (ambiente)
  testWidgets('Should display name, email, password and button components',
      (tester) async {
    await tester.pumpWidget(makeSut());

    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byKey(const Key('signUp-button')), findsOneWidget);
  });
}
