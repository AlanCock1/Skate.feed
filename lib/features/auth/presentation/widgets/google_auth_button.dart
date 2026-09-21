import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget{
  final VoidCallback onPressed;

  const GoogleAuthButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context){ 
    return SizedBox(
      height: 50,
     child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.beach_access),
        label: Text( 'Iniciar sesión con Google'),
          
      )
    );
  }
}
