import 'package:flutter/material.dart'; //Importamos flutter
import 'package:firebase_core/firebase_core.dart'; //importamos firebase
import 'firebase_options.dart'; //importamos el archivo que generó Flutterfirepara la configuración de Firebase

import 'core/di/injection.dart'; //Importamos nuestro archivo de inyección de dependencias
//import 'features/auth/presentation/pages/login_page.dart'; //Importamos la página de login 
//import 'features/auth/presentation/pages/register_page.dart';
//import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/auth/presentation/pages/complete_profile_page.dart';

Future<void> main() async { //Utilizamos 'await' porque vamos a esperar que flutter, firebase y nuestras dependencias estén inicializadas antes de ejecutar la aplicación

  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp( //Inicializamos Firebase
    options: DefaultFirebaseOptions.currentPlatform, //Usamos las opciones generadas por Flutterfire
  );

  await configureDependencies(); //Configuramos las dependencias del proyecto

  runApp(const SkateFeedApp()); //Ejecutamos la aplicación
} 
class SkateFeedApp extends StatelessWidget { //Creamos la clase principal de nuestra aplicación
  const SkateFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkateFeed', //Título de la aplicación
      theme: ThemeData( //Tema de la aplicación
        primarySwatch: Colors.blue, //Color primario de la aplicación
      ),
      home: const CompleteProfilePage(), //Pantalla principal de la aplicación
      
    );
  }
}