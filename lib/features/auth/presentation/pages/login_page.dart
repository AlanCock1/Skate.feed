import 'package:flutter/material.dart';
import 'package:skate_feed/features/auth/presentation/pages/forgot_password_page.dart';

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
import '../blocs/google_login/google_login_bloc.dart';
import '../blocs/google_login/google_login_state.dart';
import '../blocs/google_login/google_login_event.dart';


// google shi
import '../../domain/results/google_login_result.dart';

//Pages
import '../pages/register_page.dart';
import '../pages/complete_profile_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //Con esta madre vamos a validar los campos

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(   // Bloc Provider hace que ese BLoC (LoginBloc, created next line) esté disponible para los widgets que estén debajo de él.
      
      providers: [
        BlocProvider<LoginBloc>(
          create:(_) => sl<LoginBloc>()
          ),   //This line its like: “Crea un LoginBloc usando la instancia/configuración que registramos en GetIt.”
       
        BlocProvider<GoogleLoginBloc>(
          create: (_) => sl<GoogleLoginBloc>(),
        ),
      ],

      child: Builder(
      builder: (context) {
      
      return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // aquí reaccionaremos a los estados
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if(state is LoginSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Hola te mando al mapa"),
              ),
            );

            // if de google  m
          }
        },

        child: BlocListener<GoogleLoginBloc, GoogleLoginState>(
        listener:(context, state){
        // aquí reaccionaremos a los estados
        if (state is GoogleLoginFailure) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            ),
         );
        }
        if (state is GoogleLoginSuccess) {
          final result = state.result;

          if (result is GoogleLoginProfileIncomplete) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const CompleteProfilePage(),
              ),
            );
          } else if (result is GoogleLoginProfileCompleted) {
            // TODO: Navegar a la pantalla principal cuando definamos esa ruta.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Hola te mando al mapa"),
              ),
            );
          }
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
          Colors.grey,
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
                  'Welcome to Skate.feed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      EmailField(
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: passwordController,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      '¿No tienes cuenta? Regístrate aquí',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    final isLoading = state is LoginLoading;

                    return PrimaryAuthButton(
                      text: isLoading
                          ? 'Iniciando sesión...'
                          : 'Iniciar sesión',
                      onPressed: isLoading
                          ? null
                          : () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

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

                const SizedBox(height: 15),

                GoogleAuthButton(
                  onPressed: () {
                    context.read<GoogleLoginBloc>().add(
                          const GoogleLoginPressed(),
                        );
                  },
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
    },
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