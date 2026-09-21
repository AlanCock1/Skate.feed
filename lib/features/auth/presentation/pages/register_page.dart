import 'package:flutter/material.dart';

import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/username_field.dart';
import '../widgets/display_name_field.dart';
import '../widgets/birth_date_field.dart';
import '../widgets/google_auth_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey,
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
                Text(
                  'Es un gusto recibirte en Skate.feed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10),

                Text(
                  'Crea una cuenta',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30),
                EmailField(),

                SizedBox(height: 15),
                UsernameField(),

                SizedBox(height: 15),
                DisplayNameField(),

                SizedBox(height: 15),
                BirthDateField(),

                SizedBox(height: 15),
                PasswordField(),

                SizedBox(height: 15),
                PrimaryAuthButton(
                  text: 'Crear cuenta',
                  onPressed: () {
                    // Más adelante conectaremos RegisterBloc
                  },
                ),

              //----GOOGLE BUTTON-------
                SizedBox(height: 15),
                GoogleAuthButton(
                  onPressed: (){

                }),

              //----IniciaSesion TextButton------
                SizedBox(height: 15),
                Align(alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Llevará de regreso a login 
                    },

                    child: Text(
                      '¿Ya tienes cuenta? Inicia sesión aquí',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  )),
              // --------------------------------------------------

              ],
            ),
          ),
        ),
      ),
    );
  }
}