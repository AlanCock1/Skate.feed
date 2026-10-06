import 'package:flutter/material.dart';

import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/google_auth_button.dart';

//BLoc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skate_feed/core/di/injection.dart';
import 'package:skate_feed/features/auth/presentation/blocs/login/login_bloc.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(   // Bloc Provider hace que ese BLoC (LoginBloc, created next line) esté disponible para los widgets que estén debajo de él.
      create: (_) => sl<LoginBloc>(), //This line its like: “Crea un LoginBloc usando la instancia/configuración que registramos en GetIt.”
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // aquí reaccionaremos a los estados
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }


        },
      child: Scaffold(
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
            EmailField(
              controller: emailController,  //With this we receive the text writted by the user
            ),


            SizedBox(height: 20),
            PasswordField(
              controller: passwordController,
            ),

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
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final isLoading = state is LoginLoading;

              return PrimaryAuthButton(
                text: isLoading
                    ? 'Iniciando sesión...'   //Todo esto es para que dependiendo del estado del usuario (Initial o Loading), muestre el botón disponible o no. Está perro.
                    : 'Iniciar sesión',
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<LoginBloc>().add(
                          LoginSubmitted(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
              );
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
  





      ),
      ),
      ),
    );
  }
  //Los controllers ocupan recursos tons this function is for removing those resources from'em
  @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

}