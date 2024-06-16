import 'package:auto_route/auto_route.dart';
import 'package:dart_plus_app/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:dart_plus_app/presentation/widgets/button.dart';
import 'package:dart_plus_app/presentation/widgets/clickable_text.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:dart_plus_app/presentation/widgets/toastification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../domain/user_data.dart';
import '../../routes/app_router.dart';

@RoutePage()
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
          .read<LoginBloc>()
          .add(LoginUserEvent(email: email, password: password));
    } else {
      ToastificationWidget.show(
        context: context,
        message: StringsConstants.invalidFilds,
        type: ToastificationType.warning,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.read<UserData>().updateUser(state.email, state.name);
          context.pushRoute(const MyHomeRoute());
        } else if (state is LoginFailure) {
          ToastificationWidget.show(
            context: context,
            message: state.error,
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: PopScope(
            canPop: false,
            child: Stack(
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
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: CustomColor.transparentWidget,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputTextWidget(
                                  inputName: StringsConstants.email,
                                  hint: StringsConstants.insertEmail,
                                  controller: emailController,
                                  prefixIcon: Icons.person,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@')) {
                                      return StringsConstants.invalidEmail;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InputPasswordWidget(
                                  inputName: StringsConstants.password,
                                  hint: StringsConstants.insertPassword,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return StringsConstants.invalidPassword;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          ButtonWidget(
                            onClick: () => _login(context),
                            text: StringsConstants.login,
                          ),
                          const SizedBox(height: 8),
                          ClickableText(
                            text: StringsConstants.dontHaveAccount,
                            onClick: () {
                              context.pushRoute(const RegisterRoute());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
