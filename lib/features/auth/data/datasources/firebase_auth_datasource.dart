//Esta clase será el adaptador entre nuestra aplicación y Firebase.

//Su trabajo es:
//✅ Hablar con Firebase Authentication.
//✅ Crear usuarios.
//✅ Iniciar sesión.
//✅ Cerrar sesión.
//✅ Recuperar usuario actual.
//✅ Convertir resultados de Firebase → UserModel


//CHAMBAS PENDIENTES:
//verificar que el username sea único,
//enviar email de verificación,
//aceptar términos,
//validar mayoría de edad,
//manejar errores específicos de Firebase,
//foto de perfil,
//Sightengine.
 
import 'package:firebase_auth/firebase_auth.dart'; //Aquí está firebase ijijij
import 'package:cloud_firestore/cloud_firestore.dart'; //aquí está firestore 
import 'package:google_sign_in/google_sign_in.dart'; //Aquí está google_sign_in 

import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';   //Importo este para que conozca los UserRole
import 'auth_remote_datasource.dart';
import '../../domain/results/google_login_result.dart';


class FirebaseAuthRemoteDataSource
    implements AuthRemoteDataSource {

  final FirebaseAuth firebaseAuth; //Recibimos dependencias firebase
  final FirebaseFirestore firestore; //Recibimos dependencias firestore
  final GoogleSignIn googleSignIn; //Recibimos dependencias google_sign_in


  //Constructor
  FirebaseAuthRemoteDataSource( 
    this.firebaseAuth,
    this.firestore,
    this.googleSignIn,
  );
  
  


  @override   //Esto significa que estamos sobrescribiendo un método de la interfaz padre (AuthRemoteDataSource) y le estamos dando una implementación específica para Firebase.
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {

    final userCredential =  //userCredential es la respuesta de Firebase
        await firebaseAuth.signInWithEmailAndPassword(   //Esto es un método de Firebase, es básicamente decir: "Firebase, verifica si existe un usuario con este correo y contraseña."
      email: email,
      password: password,
    );

    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception('User not found'); //Esto es por si Firebase no encontró al usuario. Porque aunque no lo encuentre seguirá mandando UserCredential... pero null
    }

    final userDocument = await firestore
        .collection('users')  //Aquí le decimos a Firestore: "Oye, ve a la colección 'users' y busca el documento con este ID."
        .doc(firebaseUser.uid)
        .get();

    if (!userDocument.exists) {
      throw Exception('User profile not found');
    }

    final userData = userDocument.data();  //Recibimos los datos Map<String, dynamic> y lo guardamos en userData.
    return UserModel.fromMap(userData!); //El '!' es para decirle a Dart que estamos seguros de que userData no es null. Porque si fuera null, UserModel.fromMap() lanzaría un error.
  }





  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String username,
    required String displayName,
    required DateTime birthDate,
  }) async {

    final userCredential = 
      await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception('Failed to create user');
    }

    final userModel = UserModel(
      id: firebaseUser.uid,
      email: email,
      username: username,
      displayName: displayName,
      birthDate: birthDate,
      photoUrl: null,    
      role: UserRole.user,
      createdAt: DateTime.now(),
      status: UserStatus.active,
    );    
 
    await firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(userModel.toMap());

    return userModel;
  }




  @override
  Future<void> logout() 
  async {
    await firebaseAuth.signOut();
  }




  @override
  Future<UserModel?> getCurrentUser() 
  async {
    final firebaseUser = firebaseAuth.currentUser;
    
    if (firebaseUser == null) {
      return null;
    }

    final userDocument = await firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if(!userDocument.exists) {
      throw Exception('User profile not found');
    }

    final userData = userDocument.data();
    return UserModel.fromMap(userData!);
  }





  @override
  Future<GoogleLoginResult> loginWithGoogle() async {

    final googleUser = await googleSignIn.authenticate();

    final googleAuth = googleUser.authentication; // Obtenemos la información de autenticación de Google.
    
    final credential = GoogleAuthProvider.credential(    // Creamos credetial que Firebase Authentication entiende.
      idToken: googleAuth.idToken,
    );

    final userCredential =      
        await firebaseAuth.signInWithCredential(credential);   //Aqui creamos ya el usuario en firebase

    final firebaseUser = userCredential.user;  
   
    if (firebaseUser == null) {       //verificamps su perfil que se haya creado correctamente el usuario en Firebase
      throw Exception('Failed to sign in with Google');
    }

    final userDocument = await firestore      // Buscamos su perfil en Firestore.
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
                                  //----PERFIL ESTÁ INCOMPLETO------
    if (!userDocument.exists) {   //Si no existe el perfil en Firestore, significa que el usuario no ha completado su perfil.
      final userModel = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        username: null,
        displayName: firebaseUser.displayName ?? '',  //Si displayName NO es null, usa su valor. Si es null, utiliza '' (un String vacío)
        birthDate: null,
        photoUrl: firebaseUser.photoURL,
        role: UserRole.user,
        createdAt: DateTime.now(),
        status: UserStatus.incomplete,  //El usuario no ha completado su perfil, entonces su status es incomplete
      );

      await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(userModel.toMap());

      return GoogleLoginProfileIncomplete(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        displayName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL,
      );

    }  else{   //----PERFIL ESTÁ COMPLETO------
      final userData = userDocument.data();
      final userModel = UserModel.fromMap(userData!);

      if(userModel.status == UserStatus.incomplete){ //Si el usuario ya tiene un perfil en Firestore, pero su status es incomplete, significa que no ha completado su perfil.
        return GoogleLoginProfileIncomplete(
          uid: userModel.id,
          email: userModel.email,
          displayName: userModel.displayName,
          photoUrl: userModel.photoUrl,
        );
      }
      return GoogleLoginProfileCompleted(userModel);  //Si el status es active, significa que ya tiene su perfil completo. Tons nada más le metemos su userModel a GoogleLoginProfileCompleted y lo regresamos.
    }

  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }




  @override
  Stream<UserModel?> authStateChanges() {
    //En esta siguiente línea recibiremos el Stream<User?> que convertiremos a Stream<UserModel?>  
    return firebaseAuth.authStateChanges().asyncMap((firebaseUser) async { 

      if (firebaseUser == null) {
        return null;
      }

      final userDocument = await firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDocument.exists) {
        throw Exception('User profile not found');
      }

      final userData = userDocument.data();

      return UserModel.fromMap(userData!);
    });
  } //----AUTENTICACIÓN DE 2 PASOS (OTP)
}  