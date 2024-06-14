import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/firebase_repository_impl.dart';
import '../../../../domain/interfaces/repositories/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = AuthRepositoryImpl();

  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await authRepository.loginUser(
            email: event.email, password: event.password);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
