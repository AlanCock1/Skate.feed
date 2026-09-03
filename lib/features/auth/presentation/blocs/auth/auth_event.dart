import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable { //Este debe ser la clase padre de todos los eventos que van a pasar en el AuthBloc. Por eso es abstracta, porque no se va a instanciar directamente, sino que se va a extender por otras clases.
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

class LogoutPressed extends AuthEvent {
  const LogoutPressed();
}
  
  