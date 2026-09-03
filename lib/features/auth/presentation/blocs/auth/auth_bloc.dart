/*
En Fase 8 construimos el ferrocarril hasta AuthStateChangesUseCase. 

Ahora AuthBloc será quien escuche ese Stream y traduzca lo que está pasando en el sistema de autenticación a estados que Presentation pueda entender. 
*/

import 'package:bloc/bloc.dart';
import '../../../domain/entities/user_entity.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../domain/usecases/auth_state_changes_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import 'dart:async';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthStateChangesUseCase authStateChangesUseCase;
  final LogoutUseCase logoutUseCase;

  StreamSubscription<UserEntity?>? _authSubscription;

  //Constructor
  AuthBloc(  
   this.authStateChangesUseCase,
   this.logoutUseCase,
  ): super(const AuthLoading()) {   //El ':' significa que estamos llamando al constructor de la clase padre (Bloc) y le estamos pasando el estado inicial (AuthLoading). 
  

  on<AppStarted>((event, emit) {  //This means: "Cuando recibas un AppStarted, ejecuta este código." No estamos creando el Event, No estamos ejecutándolo, solo le estamos diciendo cómo reaccionar cuando llegue.
    
    emit(const AuthLoading()); //Wsto hace que cuando llegue AppStarted, el estado cambie a AuthLoading para que comunique "Estoy comprobando la sesión" a Presentation.

    _authSubscription = authStateChangesUseCase().listen((user) {  //Esto significa: "Cuando alguien ejecute este UseCase, devuelve el Stream del Repository. Y cuando llegue un nuevo UserEntity, ejecuta este código."


      if (user == null) {
        emit(const AuthUnauthenticated());

      } else if (user.status == UserStatus.suspended) {
        emit(AuthSuspended(user));

      } else if (user.status == UserStatus.incomplete) {
        emit(AuthIncompleteProfile(user));

      } else {
        emit(AuthAuthenticated(user));
      }
    },
    onError: (error) {
      emit(AuthFailure(error.toString()));  //Esto significa: "Si hay un error en el Stream, emite AuthFailure con el mensaje de error."

      //Falta manejo de errores

      //Cerrar la subscription correctamente
    },
  );
  });


  //---------Logout event------------------

  on<LogoutPressed>((event, emit) async {
    emit(const AuthLoading());
    try{
      await logoutUseCase();
      emit(const AuthLogoutSuccess());

    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  });

  }

  // ------CERRANDO SUBSCRIPTION------------------
  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
    
  }
}

/*
NOTAS IMPORTANTES:

La función 'listen()' permite definir 2 caminos: 
  -Cuando llega UserEntity 
  -Cuando ocurre un error
Gracias a eso es que podemos emitir AuthFailure cuando hay un error en el Stream.
  Y eso lo hacemos con el 'onError'. 


*/