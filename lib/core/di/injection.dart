import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get_it/get_it.dart';
import 'package:skate_feed/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:skate_feed/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:skate_feed/features/auth/domain/repositories/auth_repository.dart';
import 'package:skate_feed/features/auth/data/repositories/auth_repository_impl.dart';

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

}