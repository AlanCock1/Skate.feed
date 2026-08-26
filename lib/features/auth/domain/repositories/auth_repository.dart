import '../entities/user_entity.dart';
import '../../domain/results/google_login_result.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String email,
    required String password,
    required String username,
    required String displayName,
    required DateTime birthDate,
  });

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();

  Future<GoogleLoginResult> loginWithGoogle();

  Future<void> forgotPassword({
    required String email,
  });
}