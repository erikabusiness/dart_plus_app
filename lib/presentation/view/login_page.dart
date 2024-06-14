import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:dart_plus_app/presentation/widgets/button.dart';
import 'package:dart_plus_app/presentation/widgets/clickable_text.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
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
                    InputTextWidget(
                      inputName: 'E-mail',
                      hint: 'Digite seu e-mail',
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    InputPasswordWidget(
                      inputName: 'Senha',
                      hint: 'Digite sua senha',
                      controller: passwordController,
                    ),
                    const SizedBox(height: 32),
                    ButtonWidget(
                      onClick: () {},
                      text: StringsConstants.login,
                    ),
                    const SizedBox(height: 8),
                    ClickableText(
                      text: 'Não possui uma conta?', 
                      onClick: (){} //enviar para pagina register
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
