
/* 
-------QUÉ NOS FALTA-----------
  -Validaciones de los TextEditingController
  Al seleccionar no se ve nada en el campo del BirthDate
*/


import 'package:flutter/material.dart';

//WIDGETS
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/username_field.dart';
import '../widgets/display_name_field.dart';
import '../widgets/birth_date_field.dart';
import '../widgets/google_auth_button.dart';

//BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skate_feed/core/di/injection.dart';
import 'package:skate_feed/features/auth/presentation/blocs/register/register_bloc.dart';
import '../blocs/register/register_event.dart';
import '../blocs/register/register_state.dart';
import '../blocs/google_login/google_login_bloc.dart';
import '../blocs/google_login/google_login_event.dart';
import '../blocs/google_login/google_login_state.dart';

// google shi
import '../../domain/results/google_login_result.dart';

//Pages
import '../pages/complete_profile_page.dart';
import '../../../map/presentation/pages/map_page.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}  

class _RegisterPageState extends State<RegisterPage>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController= TextEditingController();
  final displayNameController = TextEditingController();
  DateTime? birthDate;  
  final formKey = GlobalKey<FormState>(); //Con esta madre vamos a validar los campos


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(  //Esta cosa is like: "Creo y pongo disponibles los BLoC.". En este caso son 2 Blocs pq tenemos el de Google y Register en la misma page.. thats why we use MultiBlocProvider instead of BlocProvider

      providers: [
        BlocProvider<RegisterBloc>(
          create: (_) => sl<RegisterBloc>(),
        ),

        BlocProvider<GoogleLoginBloc>(
          create: (_) => sl<GoogleLoginBloc>(),
        ),
      ],

      child: Builder(
      builder: (context) {
      
      return BlocListener<RegisterBloc, RegisterState>(
      listener:(context, state){
        // aquí reaccionaremos a los estados
        if (state is RegisterFailure) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            ),
         );
        }

        if (state is RegisterSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const MapPage(),
              ),
              (route) => false,
          );
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
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const MapPage(),
              ),
              (route) => false,
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
                          'Es un gusto recibirte en Skate.feed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Crea una cuenta',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),

                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 15),

                              EmailField(
                                controller: emailController,
                              ),

                              const SizedBox(height: 15),

                              UsernameField(
                                controller: usernameController,
                              ),

                              const SizedBox(height: 15),

                              DisplayNameField(
                                controller: displayNameController,
                              ),

                              const SizedBox(height: 15),

                              BirthDateField(
                                selectedDate: birthDate,
                                onDateSelected: (date) {
                                  setState(() {
                                    birthDate = date;
                                  });
                                },
                              ),

                              const SizedBox(height: 15),

                              PasswordField(
                                controller: passwordController,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            final isLoading = state is RegisterLoading;

                            return PrimaryAuthButton(
                              text: isLoading
                                  ? 'Creando cuenta...'
                                  : 'Crear cuenta',
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      if (birthDate == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Selecciona tu fecha de nacimiento',
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      context.read<RegisterBloc>().add(
                                            RegisterSubmitted(
                                              email: emailController.text.trim(),
                                              password: passwordController.text,
                                              username: usernameController.text.trim(),
                                              displayName: displayNameController.text.trim(),
                                              birthDate: birthDate!,
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

                        const SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '¿Ya tienes cuenta? Inicia sesión aquí',
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
    }, //el context del nuevo builder
    ),
  );
  }

   //Los controllers ocupan recursos tons this function is for removing those resources from'em
  @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      usernameController.dispose();
      displayNameController.dispose();
      super.dispose();
    }
}

