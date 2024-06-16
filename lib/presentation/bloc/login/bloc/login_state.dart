part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccess extends LoginState {

  final String name;
  final String email;

  const LoginSuccess({required this.name, required this.email});

  @override
  List<Object> get props => [name, email];

}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
