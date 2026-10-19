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
      
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'El nombre de usuario es obligatorio';
        }
        if (value.length > 10) {
          return 'El nombre de usuario debe ser de 10 dígitos máximo';
        }
        return null;

        // FALTA LO DE USERNAME ÚNICO
      },

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