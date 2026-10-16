import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skate_feed/core/di/injection.dart';

//WIDGETS
import '../widgets/email_field.dart';
import '../widgets/primary_auth_button.dart';

//BLoC
import '../blocs/forgot_password/forgot_password_bloc.dart';
import '../blocs/forgot_password/forgot_password_state.dart';
import '../blocs/forgot_password/forgot_password_event.dart';


class ForgotPasswordPage extends StatefulWidget {

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState(); 
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //Con esta madre vamos a validar el correo 
  
  @override
  Widget build(BuildContext context) {

// LE AÑADÍ EL BLOPROVIDER donde el injection crea el BLoC... creo
// Y EL LISTENER 
    return BlocProvider(
      create: (_) => sl<ForgotPasswordBloc>(),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state){
        // aquí reaccionaremos a los estados
          if(state is ForgotPasswordFailure){
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text(
      //Por ahora conservaré este, pero después hay que cambiarlo por mensajes aptos para el usuario.            
                  state.message,
      //Estos son mensajes para el usuario:
                 //'No pudimos procesar la solicitud. ',
                 // 'Inténtalo de nuevo más tarde.',
                  ),
                duration: const Duration(seconds: 5),
              ),
            );
          }  

          if(state is ForgotPasswordSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar( 
                content: Text(
          //Por ahora conservaré este, pero después hay que cambiarlo por mensajes aptos para el usuario.
                  "Hola si sirvo",
                  /* DESPUÉS CAMBIEMOS POR ESTOS MENSAJES:
                  'Si la dirección está registrada, recibirás un correo '
                  'con las instrucciones para restablecer tu contraseña.',
                  */),
                duration: const Duration(seconds: 4),

              ),
            );
          }    
        },

    child:  Scaffold(
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
                Form( //Con esto asociamos el campo con el FormKey para poder ejecutar la validación
                  key: formKey,
                  child: EmailField(
                    controller: emailController,
                  ),
                ),
                

                
              //AÑADÍ AQUÍ EL BLOCBUILDER, PARA ENLAZAR EL EVENTO AL BOTÓN
              // ------falta añadir el temporizador
                SizedBox(height: 15),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state){
                    final isLoading = state is ForgotPasswordLoading;

                    return PrimaryAuthButton(
                      text: isLoading
                      ? 'Enviando correo...'
                      : 'Enviar correo',
                      onPressed: isLoading 
                      ? null
                      : () {
                        if (formKey.currentState!.validate()) {
                        // El correo pasó la validación.
                          context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordSubmitted(
                              email: emailController.text,
                          ),
                        );
                        }
                      },
                    );
                  },
                ),
  

            //FALTA ESTE TMB
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
            
              // ---- Regresar a LoginPage-------
                SizedBox(height: 10),
                Align(alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                  child: Text(
                    'Regresa a Iniciar Sesión',
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
    ),
    ),
  );
  }

  @override
    void dispose() {
      emailController.dispose();
      super.dispose();
    }

}




