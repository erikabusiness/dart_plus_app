import 'package:auto_route/auto_route.dart';
import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:dart_plus_app/presentation/bloc/register/bloc/register_bloc.dart';
import 'package:dart_plus_app/presentation/styles/colors.dart';
import 'package:dart_plus_app/presentation/styles/strings.dart';
import 'package:dart_plus_app/presentation/widgets/button.dart';
import 'package:dart_plus_app/presentation/widgets/clickable_text.dart';
import 'package:dart_plus_app/presentation/widgets/input_password.dart';
import 'package:dart_plus_app/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../di/service_locator.dart';
import '../../routes/app_router.dart';
import '../widgets/toastification.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  final VoidCallback? onLogin;

  const RegisterPage({this.onLogin, super.key});

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

      widget.onLogin?.call();

      context
          .read<RegisterBloc>()
          .add(RegisterUserEvent(name: name, email: email, password: password));
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
    return BlocProvider(
      create: (context) =>
          RegisterBloc(authRepository: getIt<AuthRepository>()),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ToastificationWidget.show(
                context: context,
                message: StringsConstants.successCreateAccount,
                type: ToastificationType.success);
            context.pushRoute(const LoginRoute());
          } else if (state is RegisterFailure) {
            ToastificationWidget.show(
              context: context,
              message: state.error,
              type: ToastificationType.error,
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
                Align(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
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
                                  inputName: StringsConstants.name,
                                  hint: StringsConstants.insertName,
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return StringsConstants.ruleName;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InputTextWidget(
                                  inputName: StringsConstants.email,
                                  hint: StringsConstants.insertEmail,
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
                                  inputName: StringsConstants.password,
                                  hint: StringsConstants.insertPassword,
                                  controller: passwordController,
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return StringsConstants.invalidPassword;
                                    }
                                    if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~`]).{6,}$')
                                        .hasMatch(value)) {
                                      return StringsConstants.rulePassword;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InputPasswordWidget(
                                  inputName: StringsConstants.confirmPassword,
                                  hint: StringsConstants
                                      .insertPasswordConfirmation,
                                  controller: confirmPasswordController,
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return StringsConstants.invalidPassword;
                                    }
                                    if (value != passwordController.text) {
                                      return StringsConstants
                                          .invalidPasswordConfirmation;
                                    }
                                    if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?~`]).{6,}$')
                                        .hasMatch(value)) {
                                      return StringsConstants.rulePassword;
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
                              text: StringsConstants.haveAccount,
                              onClick: () {
                                context.pushRoute(const LoginRoute());
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
