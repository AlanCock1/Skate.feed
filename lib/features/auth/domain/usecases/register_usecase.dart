import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
    required String username,
    required String displayName,
    required DateTime birthDate,
  }) {
    return _repository.register(
      email: email,
      password: password,
      username: username,
      displayName: displayName,
      birthDate: birthDate,
    );
  }
}