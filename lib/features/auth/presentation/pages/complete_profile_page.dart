  import 'package:flutter/material.dart';

  import '../widgets/primary_auth_button.dart';
  import '../widgets/username_field.dart';
  import '../widgets/display_name_field.dart';
  import '../widgets/birth_date_field.dart';


class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});
   @override
   State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
    final usernameController = TextEditingController();
    final displayNameController = TextEditingController();
    DateTime? birthDate;
    
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
              UsernameField(
                controller: usernameController,
              ),

              SizedBox(height: 15),
              DisplayNameField(
                controller: displayNameController,
              ),

              SizedBox(height: 15),
              BirthDateField(onDateSelected: (date) {
                setState(() {
                  birthDate = date;
                });
              },),

          
          // ---- Login Button -------
            SizedBox(height: 30),
            PrimaryAuthButton( //Chat... Aquí qué hago? Porque en los demás pages aplicamos el BlocBuilder pero en este caso no hay Bloc para complete_page.
                text: 'Empezar',
                onPressed: () {
                  //Aquí irá completePageBloc
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
  @override
    void dispose() {
      usernameController.dispose();
      displayNameController.dispose();
      super.dispose();
    }

  }