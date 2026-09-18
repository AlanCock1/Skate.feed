  import '../entities/user_entity.dart';

  sealed class GoogleLoginResult {
    const GoogleLoginResult();
  }

  class GoogleLoginProfileCompleted extends GoogleLoginResult {
    final UserEntity user;

    const GoogleLoginProfileCompleted(this.user);
  }

  class GoogleLoginProfileIncomplete extends GoogleLoginResult {
  final String uid;
    final String email;
    final String? displayName;
    final String? photoUrl;
    
    const GoogleLoginProfileIncomplete({
      required this.uid,
      required this.email,
      this.displayName,
      this.photoUrl,
    });
  }