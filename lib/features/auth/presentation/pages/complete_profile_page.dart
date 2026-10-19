import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skate_feed/core/di/injection.dart';


//WIDGETS
import '../widgets/primary_auth_button.dart';
import '../widgets/username_field.dart';
import '../widgets/display_name_field.dart';
import '../widgets/birth_date_field.dart';

//BLoC
import '../blocs/complete_profile/complete_profile_state.dart';
import 'package:skate_feed/features/auth/presentation/blocs/complete_profile/complete_profile_event.dart';
import 'package:skate_feed/features/auth/presentation/blocs/complete_profile/complete_profile_bloc.dart';


class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});
   @override
   State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
    final usernameController = TextEditingController();
    final displayNameController = TextEditingController();
    DateTime? birthDate;
    final formKey = GlobalKey<FormState>(); //Con esta madre vamos a validar los campos

    
    @override
    Widget build(BuildContext context) {
      return BlocProvider(
      create: (_) => sl<CompleteProfileBloc>(), //El BLoC nace mediante DI
      child:BlocListener<CompleteProfileBloc, CompleteProfileState>(
        listener:(context, state){
         //Aqui reaccionamos a los estados
         if(state is CompleteProfileFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
         }
         if(state is CompleteProfileSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Hola te mando al mapa"),
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
                'Solo un pequeño paso más para comenzar...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

              
              Form(
                key: formKey,
                child: Column(
                  children: [
                    
                    SizedBox(height: 15),
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
                  ],
                ),
              ),


          
          // ---- Login Button -------
            SizedBox(height: 30),
            BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
              builder: (context, state) {
                final isLoading = state is CompleteProfileLoading;

                return PrimaryAuthButton(
                  text: isLoading
                  ? 'Completando Cuenta...'
                  : 'Completar Cuenta', 
                  onPressed: isLoading
                  ? null
                  : () {
                     if (!formKey.currentState!.validate()) {
                        return;
                      }         
                  
                    context.read<CompleteProfileBloc> ().add(
                      CompleteProfileSubmitted(
                        username: usernameController.text, 
                        displayName: displayNameController.text, 
                        birthDate: birthDate!
                      ),
                    );
                  },
                );
              },
            ),
          // --------------------------------------------------

      


            ],
          ),
        ),
      ),
    )
  ),
  ),
  );
  }
  @override
    void dispose() {
      usernameController.dispose();
      displayNameController.dispose();
      super.dispose();
    }

  }