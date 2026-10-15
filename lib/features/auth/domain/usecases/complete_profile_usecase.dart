import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileUseCase {
  final AuthRepository _repository;

  const CompleteProfileUseCase(this._repository);

  Future<UserEntity> call({
    required String username,
    required String displayName,
    required DateTime birthDate,
  }) {
    return _repository.completeProfile(
      username: username, 
      displayName: displayName, 
      birthDate: birthDate
      );

  }
}