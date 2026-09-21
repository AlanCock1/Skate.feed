import 'package:flutter/material.dart';

import '../widgets/email_field.dart';
import '../widgets/primary_auth_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                  'Recupera tu contraseña',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10),

                Text(
                  'Te enviaremos un correo para renovar tu contraseña',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30),
                EmailField(),

                SizedBox(height: 15),
                PrimaryAuthButton(
                  text: 'Enviar correo',
                  onPressed: () {
                    // Más adelante conectaremos ForgotPasswordBloc
                  },
                ),

                SizedBox(height: 20),
                Text(
                  'Mensaje de exito o error', //Esto cambiará después cuando le metamos la logica del Bloc
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                
              //----REENVIAR CORREO------------
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    // Más adelante controlaremos el reenvío y el temporizador
                  },
                  child: Text(
                    '¿No recibiste el correo? Reenviar',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              //-----------------------





              ],
            ),
          ),
        ),
      ),
    );
  }
}