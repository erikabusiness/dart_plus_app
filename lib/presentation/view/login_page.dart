import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:dart_plus_app/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:dart_plus_app/presentation/widgets/button.dart';
import 'package:dart_plus_app/presentation/widgets/clickable_text.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:dart_plus_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final email = emailController.text;
      final password = passwordController.text;

      context
          .read()<LoginBloc>()
          .add(LoginUserEvent(email: email, password: password));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Preencha corretamente os campos Email e Senha")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, NavRoutes.homePage);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                const Image(
                  image: AssetImage('assets/bg-login.jpg'),
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        color: CustomColor.transparentWidget,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InputTextWidget(
                            inputName: 'E-mail',
                            hint: 'Digite seu e-mail',
                            controller: emailController,
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Insira um email válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          InputPasswordWidget(
                            inputName: 'Senha',
                            hint: 'Digite sua senha',
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira uma senha válida';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          ButtonWidget(
                            onClick: () => _login,
                            text: StringsConstants.login,
                          ),
                          const SizedBox(height: 8),
                          ClickableText(
                              text: 'Não possui uma conta?',
                              onClick: () {
                                Navigator.pushNamed(
                                    context, NavRoutes.registerPage);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
