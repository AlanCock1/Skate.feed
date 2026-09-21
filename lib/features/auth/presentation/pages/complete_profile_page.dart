  import 'package:flutter/material.dart';

  import '../widgets/primary_auth_button.dart';
  import '../widgets/username_field.dart';
  import '../widgets/display_name_field.dart';
  import '../widgets/birth_date_field.dart';


  class CompleteProfilePage extends StatelessWidget {
    const CompleteProfilePage({super.key});

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
                'Solo un pequeño paso más para comenzar...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
              SizedBox(height: 15),
              UsernameField(),

              SizedBox(height: 15),
              DisplayNameField(),

              SizedBox(height: 15),
              BirthDateField(),

          
          // ---- Login Button -------
            SizedBox(height: 30),
            PrimaryAuthButton(
                text: 'Empezar',
                onPressed: () {
                  //Aquí irá loginBloc
                },
              ),
          // --------------------------------------------------

      


            ],
          ),
        ),
      ),
    )
  );
  }
  }