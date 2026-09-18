// ---FUNCIONAMIENTO---
// Gestiona el proceso de registro de nuevos usuarios.
// Recibe los datos del formulario mediante RegisterSubmitted, ejecuta
// RegisterUseCase y emite Loading, Success o Failure según el resultado.
import 'package:bloc/bloc.dart';

import '../register/register_event.dart';
import '../register/register_state.dart';
import '../../../domain/usecases/register_usecase.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) 
  : super(const RegisterInitial()) {
    
    on<RegisterSubmitted>((event, emit) async {
      emit(const RegisterLoading());
      try {
        final user = await registerUseCase(
          email: event.email,
          password: event.password,
          username: event.username,
          displayName: event.displayName,
          birthDate: event.birthDate,
        );

        emit(RegisterSuccess(user));
      } catch (error) {
        emit(RegisterFailure(error.toString()));
      }
    });
  }
}