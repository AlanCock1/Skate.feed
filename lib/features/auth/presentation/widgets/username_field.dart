import 'package:flutter/material.dart';


class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({
    super.key,
    required this.controller
    });
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      
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