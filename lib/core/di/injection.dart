import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get_it/get_it.dart';
import 'package:skate_feed/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:skate_feed/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:skate_feed/features/auth/domain/repositories/auth_repository.dart';
import 'package:skate_feed/features/auth/data/repositories/auth_repository_impl.dart';

//Use cases
import 'package:skate_feed/features/auth/domain/usecases/login_usecase.dart';
import 'package:skate_feed/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:skate_feed/features/auth/domain/usecases/logout_usecase.dart';
import 'package:skate_feed/features/auth/domain/usecases/register_usecase.dart';
import 'package:skate_feed/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:skate_feed/features/auth/domain/usecases/auth_state_changes_usecase.dart';

import 'package:skate_feed/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:skate_feed/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:skate_feed/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:skate_feed/features/auth/presentation/blocs/google_login/google_login_bloc.dart';
import 'package:skate_feed/features/auth/presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {

  sl.registerLazySingleton<FirebaseAuth>(  //registerLazySingleton significa: "Cuando alguien necesite un FirebaseAuth, dame esta misma instancia de Firebase, y créala/obténla solo cuando realmente se necesite."
  () => FirebaseAuth.instance,
  );                                          //YYYY la sintaxis se podría explicar así: "GetIt, registra una dependencia cuyo tipo es FirebaseAuth; cuando alguien la necesite, entrégale FirebaseAuth.instance."
  
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn.instance,
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(  
    () => FirebaseAuthRemoteDataSource(     //
      sl<FirebaseAuth>(), 
      sl<FirebaseFirestore>(), 
      sl<GoogleSignIn>(),
      )
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
    )
  );

//-----USE CASES--------------------

  sl.registerLazySingleton<AuthStateChangesUseCase>(
    () => AuthStateChangesUseCase(
      sl<AuthRepository>(),
    )
  );

  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(
      sl<AuthRepository>(),
    )
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      sl<AuthRepository>(),
    )
  );
  
  sl.registerLazySingleton<LoginWithGoogleUseCase>(
    () => LoginWithGoogleUseCase(
      sl<AuthRepository >(),
    )
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      sl<AuthRepository>(),
    )
  );

  //------BLoCs----------------

  sl.registerFactory<LoginBloc>(
  () => LoginBloc(
    sl<LoginUseCase>(),
  ),
);

  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      sl<RegisterUseCase>(),
    ),
  );

  sl.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(
      sl<ForgotPasswordUseCase>(),
    ),
  );

  sl.registerFactory<GoogleLoginBloc>(
    () => GoogleLoginBloc(
      sl<LoginWithGoogleUseCase>(),
    ),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sl<AuthStateChangesUseCase>(),
      sl<LogoutUseCase>(),
    ),
  );

  
}
