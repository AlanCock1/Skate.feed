import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key});
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Ingresa tu nombre de usuario',
        prefixIcon: Icon(Icons.person_outline),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}