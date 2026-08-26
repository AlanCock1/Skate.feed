import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/results/google_login_result.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository{
  
  final AuthRemoteDataSource remoteDataSource;
  
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
    }) async {

    final userModel = await remoteDataSource.login(
    email: email,
    password: password,
  );

  return userModel;
}

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String username,
    required String displayName,
    required DateTime birthDate,
  }) async {
    final userModel = await remoteDataSource.register(
      email: email, 
      password: password, 
      username: username, 
      displayName: displayName, 
      birthDate: birthDate
    );
    return userModel;
  }

  @override
  Future<void> logout() async { 
    await remoteDataSource.logout();
  }

  @override 
  Future<UserEntity?> getCurrentUser() async {
  final userModel = await remoteDataSource.getCurrentUser();
  
  return userModel;
  }

  @override
  Future<GoogleLoginResult> loginWithGoogle() async {
    final result = await remoteDataSource.loginWithGoogle();

    return result;
  }


  @override
  Future<void> forgotPassword({ 
    required String email,
  }) async { 

    await remoteDataSource.forgotPassword(
      email: email
      ); 
  }
}