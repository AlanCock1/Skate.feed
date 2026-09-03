import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

/*
 Estos son todos mis estados posibles del AuthBloc, los cuales son:
  1. AuthLoading → sin propiedades.

  2. AuthUnauthenticated   → sin propiedades.

  3. AuthIncompleteProfile → UserEntity user.

  4. AuthAuthenticated     → UserEntity user.

  5. AuthSuspended         → UserEntity user.

  6. AuthFailure           → String message.

  7. AuthLogoutSuccess     → sin propiedades.
*/
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
} 


//------AUTH LOADING------------------
class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => [];
}

//------AUTH UNAUTHENTICATED------------------
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();

  @override
  List<Object?> get props => [];
}

//------AUTH INCOMPLETE PROFILE------------------ USER ENTITY
class AuthIncompleteProfile extends AuthState { 
  final UserEntity user;

  const AuthIncompleteProfile(this.user);

  @override
  List<Object?> get props => [user];
}

//------AUTH AUTHENTICATED------------------ USER ENTITY
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}


//------AUTH SUSPENDED------------------ USER ENTITY
class AuthSuspended extends AuthState {
  final UserEntity user;

  const AuthSuspended(this.user);

  @override
  List<Object?> get props => [user];
}

//------AUTH FAILURE------------------
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//------AUTH LOGOUT SUCCESS------------------
class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess();

  @override
  List<Object?> get props => [];
}





/*
AuthLoading → sin propiedades.
AuthUnauthenticated → sin propiedades.
AuthAuthenticated → UserEntity user.
AuthIncompleteProfile → piensa si necesitamos llevar el UserEntity también 👀.
AuthSuspended → misma pregunta 👀.
AuthFailure → String message.
AuthLogoutSuccess → sin propiedades.
*/
