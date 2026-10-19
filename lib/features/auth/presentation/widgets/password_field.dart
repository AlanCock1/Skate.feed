import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.controller
    });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'La contraseña es obligatoria';
        }

        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }

        return null;
      },
      
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintText: 'Ingresa tu contraseña',
        prefixIcon: Icon(Icons.lock_outline),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}