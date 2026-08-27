//Esta interfaz es como: ¿Cómo obtenemos/enviamos esos datos a una fuente externa? 

import '../models/user_model.dart';
import '../../domain/results/google_login_result.dart';


abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String email,
    required String password,
    required String username,
    required String displayName,
    required DateTime birthDate,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<GoogleLoginResult> loginWithGoogle();

  Future<void> forgotPassword({
    required String email,
  });

  Stream<UserModel?> authStateChanges(); //Este es para detectar cada cambio de estado del usuario
}