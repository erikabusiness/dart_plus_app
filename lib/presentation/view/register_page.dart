import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:dart_plus_app/presentation/widgets/button.dart';
import 'package:dart_plus_app/presentation/widgets/clickable_text.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color:  CustomColor.transparentWidget,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    InputTextWidget(
                      inputName: 'Nome',
                      hint: 'Digite seu nome',
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    InputTextWidget(
                      inputName: 'E-mail',
                      hint: 'Digite seu e-mail',
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
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
                    ),
                    const SizedBox(height: 16),
                    InputPasswordWidget(
                      inputName: 'Confirmar Senha',
                      hint: 'Confirme sua senha',
                      controller: confirmPasswordController,
                    ),
                    const SizedBox(height: 32),
                    ButtonWidget(
                      onClick: () {},
                      text: StringsConstants.register,
                    ),
                    const SizedBox(height: 8),
                    ClickableText(
                      text: 'Já possui uma conta?', 
                      onClick: (){} //enviar para pagina login
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
