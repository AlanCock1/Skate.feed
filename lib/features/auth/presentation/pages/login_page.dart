import 'package:flutter/material.dart';

import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/google_auth_button.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey,
              Colors.black,
            ],
          ),
        ),


      child: Center(
        child: SizedBox(
        width: 350,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            //---- TITLE ------
            Text(
              'Welcome to Skate.feed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),



            SizedBox(height: 40),
            Text(
              'Inicia sesión para continuar',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),


            SizedBox(height: 25),
            EmailField(),


            SizedBox(height: 20),
            PasswordField(),

        // ---- ForgotPassword Text-------
            SizedBox(height: 10),

            Align(alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Llevará a ForgotPasswordPage 
              },

              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            )),
        // --------------------------------------------------

        // ---- Login Button -------
          SizedBox(height: 30),
          PrimaryAuthButton(
              text: 'Iniciar sesión',
              onPressed: () {
                 //Aquí irá loginBloc
              },
            ),
        // --------------------------------------------------

        //----Google Login----- 
        SizedBox(height: 15 ),
        GoogleAuthButton(
          onPressed: () {
              //GoogleLoginBloc 
          }) 



          ],
        ),
      ),
    ),
  



















      )
    );
  }


}