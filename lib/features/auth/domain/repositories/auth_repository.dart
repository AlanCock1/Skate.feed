import '../entities/user_entity.dart';

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

  Future<UserEntity> loginWithGoogle();

  Future<void> forgotPassword({
    required String email,
  });
}