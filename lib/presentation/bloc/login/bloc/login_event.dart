part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginUserEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
