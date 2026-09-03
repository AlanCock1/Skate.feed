
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthStateChangesUseCase {
  final AuthRepository _repository;

  const AuthStateChangesUseCase(this._repository);

  Stream<UserEntity?> call() {
    return _repository.authStateChanges();    //Esto significa: "Cuando alguien ejecute este UseCase, devuelve el Stream del Repository."
  }
}