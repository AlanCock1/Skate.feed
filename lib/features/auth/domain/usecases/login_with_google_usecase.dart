import 'package:skate_feed/features/auth/domain/results/google_login_result.dart';

import '../repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  final AuthRepository _repository;

  const LoginWithGoogleUseCase(this._repository);

  Future<GoogleLoginResult> call() {
    return _repository.loginWithGoogle();
  }
}