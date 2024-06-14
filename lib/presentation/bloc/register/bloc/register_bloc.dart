import 'package:dart_plus_app/domain/interfaces/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/firebase_repository_impl.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository = AuthRepositoryImpl();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        await authRepository.registerUser(
            name: event.name, email: event.email, password: event.password);
        emit(RegisterSuccess());
      } catch (e) {
        print("ERRO LOGGER ${e.toString()}");
        emit(RegisterFailure(error: e.toString()));
      }
    });
  }
}
