import 'package:dart_plus_app/data/repositories/firebase_repository_impl.dart';
import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:dart_plus_app/presentation/bloc/register/bloc/register_bloc.dart';
import 'package:dart_plus_app/presentation/view/register_page.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // Teste da página de cadastro de usuário
  final name = faker.person.name();
  final email = faker.internet.email();
  final password = faker.internet.password();
  final confirmPassword = password;

  late int counter;

  void incrementCounter() => counter++;

  final getIt = GetIt.instance;

  Future<void> setUpLocator() async {
    getIt.registerSingleton<AuthRepository>(FakeAuthRepository());
    getIt.registerSingleton<RegisterBloc>(
      RegisterBloc(
        authRepository: FakeAuthRepository(),
      ),
    );
  }

  setUpAll(() async {
    await setUpLocator();
  });

  setUp(() {
    counter = 0;
  });

  // Primeiro teste TDD - Teste de Validação de componentes (ambiente)
  testWidgets('Should display input text widget', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RegisterPage()),
    );

    expect(find.byType(InputTextWidget), findsNWidgets(2)); //nome e email
  });

  tearDownAll(
    () => getIt.reset(),
  );

// // Primeiro teste TDD - Teste de Validação de componentes (ambiente)
//   testWidgets('Should display only name, email, password and button components',
//       (tester) async {
//     await tester.pumpWidget(
//       const MaterialApp(home: RegisterPage(

//       )),
//     );

//     expect(find.byType(InputTextWidget), findsNWidgets(2)); //nome e email
//     expect(find.byType(InputPasswordWidget),
//         findsNWidgets(2)); //senha e confirmação de senha
//     expect(
//         find.byKey(const Key('button')), findsOneWidget); //botão de cadastrar
//   });
}
  // Validar a funcionalidade (sucesso)
//   testWidgets('Should tap button correctly when with email & password',
//       (tester) async {
//     await tester.pumpWidget(makeSut());

//     await fillLoginFormAndSubmit(
//         tester, name, email, password, confirmPassword);

//     await tester.pump();

//     expect(counter, 1);
//   });

// //  testWidgets('Should exhibit a error dialog when the email is wrong',
// //       (tester) async {
// //     await tester.pumpWidget(makeSut());

// //     await fillLoginFormAndSubmit(tester, 'email inválido', '');

// //     await tester.pumpAndSettle(); // Pular frames até completar a ação

// //     expect(find.byKey(const Key('error-dialog')), findsOneWidget);
// //   });
// }

// Future<void> fillLoginFormAndSubmit(tester, String name, String email,
//     String password, String confirmPassword) async {
//   final finder = find.byType(InputTextWidget);

//   await tester.enterText(finder.first, name);
//   await tester.enterText(finder.last, email);

//   await tester.pump();

//   final findPassword = find.byType(InputPasswordWidget);

//   await tester.enterText(findPassword.first, password);
//   await tester.enterText(findPassword.last, confirmPassword);

//   await tester.pump();

//   final button = find.byKey(const Key('button'));

//   await tester.tap(button);
// }
class FakeAuthRepository extends Mock implements AuthRepository {}