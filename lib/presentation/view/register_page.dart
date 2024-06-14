import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:dart_plus_app/presentation/bloc/register/bloc/register_bloc.dart';
import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:dart_plus_app/presentation/widgets/button.dart';
import 'package:dart_plus_app/presentation/widgets/clickable_text.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:dart_plus_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _register(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      context
          .read<RegisterBloc>()
          .add(RegisterUserEvent(name: name, email: email, password: password));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha corretamente todos os campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushNamed(context, NavRoutes.loginPage);
          } else if (state is RegisterFailure) {
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
                          const SizedBox(height: 16),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputTextWidget(
                                  inputName: 'Nome',
                                  hint: 'Digite seu nome',
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'O nome é obrigatório.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InputTextWidget(
                                  inputName: 'E-mail',
                                  hint: 'Digite seu e-mail',
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@')) {
                                      return StringsConstants.invalidEmail;
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                ),
                                const SizedBox(height: 16),
                                InputPasswordWidget(
                                  inputName: 'Senha',
                                  hint: 'Digite sua senha',
                                  controller: passwordController,
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'A senha é obrigatória.';
                                    }
                                    if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~`]).{8,}$')
                                        .hasMatch(value)) {
                                      return 'A senha deve conter pelo menos 8 caracteres, incluindo pelo menos uma letra maiúscula, um número e um caractere especial.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InputPasswordWidget(
                                  inputName: 'Confirmar Senha',
                                  hint: 'Confirme sua senha',
                                  controller: confirmPasswordController,
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'A senha é obrigatória.';
                                    }
                                    if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~`]).{8,}$')
                                        .hasMatch(value)) {
                                      return 'A senha deve conter pelo menos 8 caracteres, incluindo pelo menos uma letra maiúscula, um número e um caractere especial.';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          ButtonWidget(
                            onClick: () => _register(context),
                            text: StringsConstants.register,
                          ),
                          const SizedBox(height: 8),
                          ClickableText(
                              text: 'Já possui uma conta?',
                              onClick: () {
                                Navigator.pushNamed(
                                    context, NavRoutes.loginPage);
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
