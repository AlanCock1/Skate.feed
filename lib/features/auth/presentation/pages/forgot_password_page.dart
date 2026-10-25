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

//TIMER
import 'dart:async';

class ForgotPasswordPage extends StatefulWidget {

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState(); 
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //Con esta madre vamos a validar el correo 
  Timer? resendTimer;
  int secondsRemaining = 0;
  bool emailSent = false;
  bool showResendMessage = false;
  
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
            // Añado aquí el emailSent porque así, el temporizador comienza solo cuando la solicitud termina correctamente, no cuando el usuario pulsa el botón.
            setState(() {
              emailSent = true;
              showResendMessage = true;
            });
            startResendTimer();


            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar( 
                content: Text(
          //Por ahora conservaré este, pero después hay que cambiarlo por mensajes aptos para el usuario.
                  "Hola si sirvo",
                  /* DESPUÉS CAMBIEMOS POR ESTOS MENSAJES:
                  'Si la dirección está registrada, recibirás un correo '
                  'con las instrucciones para restablecer tu contraseña.',
                  */),
                duration: const Duration(seconds: 5),

              ),
            );
          }    
        },

   
          child: Scaffold(
            backgroundColor: Colors.black,
            resizeToAvoidBottomInset: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
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
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 350,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          const Text(
                            'Recupera tu contraseña',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            'Te enviaremos un correo para renovar tu contraseña',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 30),
                          Form(
                            key: formKey,
                            child: EmailField(
                              controller: emailController,
                            ),
                          ),

                      //  -----  ENVIAR CORREO --------------
                          const SizedBox(height: 15),
                          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                            builder: (context, state) {
                              final isLoading =
                                  state is ForgotPasswordLoading;

                              final isCoolingDown =
                                  emailSent && secondsRemaining > 0;

                              final isDisabled =
                                  isLoading || isCoolingDown;

                              return PrimaryAuthButton(
                                text: isLoading
                                    ? 'Enviando correo...'
                                    : 'Enviar correo',
                                onPressed: isDisabled
                                    ? null
                                    : () {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }

                                        context.read<ForgotPasswordBloc>().add(
                                              ForgotPasswordSubmitted(
                                                email: emailController.text.trim(),
                                              ),
                                            );
                                      },
                              );
                            },
                          ),

                    // ---- REENVIAR CORREO -------------
                          const SizedBox(height: 15),
                          if (showResendMessage && secondsRemaining > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                'Reenviar correo en ${secondsRemaining}s',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                      // --- REGRESAR A LOGIN ------
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Regresa a Iniciar Sesión',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
      resendTimer?.cancel();
      super.dispose();
    }


  // FUNCIÓN DEL TIMER
  void startResendTimer() {
    resendTimer?.cancel();

    setState(() {
      secondsRemaining = 60;
    });

    resendTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondsRemaining <= 1) {
          timer.cancel();

          setState(() {
            secondsRemaining = 0;
          });
        } else {
          setState(() {
            secondsRemaining--;
          });
        }
      },
    );
  }

}




