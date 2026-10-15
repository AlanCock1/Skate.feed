import 'package:equatable/equatable.dart';
import '../../../domain/results/google_login_result.dart';

abstract class GoogleLoginState extends Equatable {
  const GoogleLoginState();

  @override
  List<Object?> get props => [];
}

class GoogleLoginInitial extends GoogleLoginState {
  const GoogleLoginInitial();
}

class GoogleLoginLoading extends GoogleLoginState {
  const GoogleLoginLoading();
}

class GoogleLoginSuccess extends GoogleLoginState {
  final GoogleLoginResult result;

  const GoogleLoginSuccess(this.result);
  
  @override
  List<Object?> get props => [result];
}

class GoogleLoginFailure extends GoogleLoginState {
  final String message;

  const GoogleLoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//NOS QUEDAMOS AQUÍ.

//Con la duda de GoogleLoginResult, si es correcto o no. Porque en el BLoC no debería conocer si el perfil de google está completo o no. 
//La idea de chat de irnos por el camino A es la que nos gustó, nada más nos falta entenderla pa.