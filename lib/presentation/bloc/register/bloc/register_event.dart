part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  const RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
