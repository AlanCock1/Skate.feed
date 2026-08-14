import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository; //El '_' hace el repositorio privado al archivo. Para evitar accesos accidentales desde afuera.

  const LoginUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) {
    return _repository.login(
      email: email,
      password: password,
    );
  }
}