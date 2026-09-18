import 'package:equatable/equatable.dart';

abstract class GoogleLoginEvent extends Equatable {
  const GoogleLoginEvent();

  @override
  List<Object?> get props => [];
}

class GoogleLoginPressed extends GoogleLoginEvent {
  const GoogleLoginPressed(); //No pido ningun dato porque en mi login_with_google__usecase no pido nada así que no hay props.

  @override
  List<Object?> get props => [];
} 