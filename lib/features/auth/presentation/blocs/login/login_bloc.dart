//  ---FUNCIONAMIENTO---
//  Gestiona el proceso de inicio de sesión.
//  Recibe las credenciales mediante LoginSubmitted, ejecuta LoginUseCase
//  y emite Loading, Success o Failure según el resultado.



import 'package:bloc/bloc.dart';

import '../login/login_event.dart';
import '../login/login_state.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase)
  : super(const LoginInitial()) {
        
    on<LoginSubmitted>((event, emit) async {
      emit(const LoginLoading());
      try {
        final user = await loginUseCase(
            email : event.email, 
            password : event.password,
        );

      emit(LoginSuccess(user));

      } catch (error) {
          emit(LoginFailure(error.toString()));
        }
      
    });
  }
}

