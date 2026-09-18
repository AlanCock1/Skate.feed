// ---FUNCIONAMIENTO---
// Gestiona el inicio de sesión mediante Google.
// Recibe GoogleLoginPressed, ejecuta LoginWithGoogleUseCase y emite
// Loading, Success o Failure. El resultado indica si el perfil está completo.
import 'package:bloc/bloc.dart';

import 'google_login_event.dart';
import 'google_login_state.dart';
import '../../../domain/usecases/login_with_google_usecase.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  GoogleLoginBloc(this.loginWithGoogleUseCase)
      : super(const GoogleLoginInitial()) {

    on<GoogleLoginPressed>((event, emit) async {
      emit(const GoogleLoginLoading());
      try {
        final result = await loginWithGoogleUseCase();
        emit(GoogleLoginSuccess(result));
        
      } catch (error) {
        emit(GoogleLoginFailure(error.toString()));
      }
    });
  }
}