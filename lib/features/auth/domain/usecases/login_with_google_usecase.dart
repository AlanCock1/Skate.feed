import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  final AuthRepository _repository;

  const LoginWithGoogleUseCase(this._repository);

  Future<UserEntity> call() {
    return _repository.loginWithGoogle();
  }
}