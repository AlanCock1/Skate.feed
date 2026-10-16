// ---FUNCIONAMIENTO---
// Gestiona la solicitud de recuperación de contraseña.
// Recibe el correo mediante ForgotPasswordSubmitted, ejecuta
// ForgotPasswordUseCase y emite Loading, Success o Failure.

import 'package:bloc/bloc.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc(this.forgotPasswordUseCase)
      : super(const ForgotPasswordInitial()) {

    on<ForgotPasswordSubmitted>((event, emit) async {
      print('🔥# # # # ForgotPasswordPressed recibido');
      emit(const ForgotPasswordLoading());

      try {
        await forgotPasswordUseCase(
          email: event.email
          );
        print('🔥 ##### ForgotPassword terminó correctamente');
        emit(const ForgotPasswordSuccess());

      } catch (error) {
        print('🔥 #### ERROR Forgot Password: $error');
        emit(ForgotPasswordFailure(error.toString()));
      }
    });
  }
}