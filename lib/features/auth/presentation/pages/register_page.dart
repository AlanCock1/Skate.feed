
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
      },

      child: Scaffold(
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
                  EmailField(
                    controller: emailController,
                  ),

                  SizedBox(height: 15),
                  UsernameField(
                    controller: usernameController,
                  ),

                  SizedBox(height: 15),
                  DisplayNameField(
                    controller: displayNameController,
                  ),

                  SizedBox(height: 15),
                  BirthDateField(
                    onDateSelected: (date) { // Esto significa: Cuando BirthDateField me entregue una fecha, recibe esa fecha aquí como date
                      setState(() {  //Esta madre es para el callback 
                        birthDate = date;
                      });
                    },
                  ),

                  SizedBox(height: 15),
                  PasswordField(
                    controller: passwordController,
                  ),

                  SizedBox(height: 15),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      final isLoading = state is RegisterLoading;

                      return  PrimaryAuthButton(
                        text: isLoading
                          ? 'Creando cuenta...'
                          : 'Crear cuenta',
                        onPressed: isLoading
                         ? null
                         : () {
                              if (birthDate == null) {   //Este if es la validación del campo de birtDate. Para que si el usuario no selecciono ninguna fecha, no entre el evento
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Selecciona tu fecha de nacimiento'),
                                    ),
                                  );
                                  return;
                                }

                              context.read<RegisterBloc>().add(
                                RegisterSubmitted(
                                  email: emailController.text,
                                  password: passwordController.text, 
                                  username: usernameController.text, 
                                  displayName: displayNameController.text, 
                                  birthDate: birthDate!,
                      
                                ),
                              );
                         }, 
                      );
                    },
                  ),
              // --------------------------------------------------

                //----GOOGLE BUTTON-------
                  SizedBox(height: 15),
                  GoogleAuthButton(
                    onPressed: (){
                      context.read<GoogleLoginBloc>().add(
                        const GoogleLoginPressed(),
                      );

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

